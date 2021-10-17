terraform {
#  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}
provider "aws" {
  region = var.aws-region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_eip" "nat" {
  count = 2
  vpc = true
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"
  name = var.vpc-name
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws-region}a", "${var.aws-region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_ipv6 = false

  # enable_nat_gateway = true
  # single_nat_gateway = true
  # one_nat_gateway_per_az = false
# Uncomment above if you need single NAT Gateway

#below would ensure NAT gateway per AZ
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module

  create_igw = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  # public_subnet_tags = {
  #   Name = "sheda-vpc-public"
  # }

  tags = {
    Owner       = "user"
    Environment = "dev"
    Terraform = "true"
  }

  vpc_tags = {
    Name = var.vpc-name
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}
module "security_group_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${var.public-ip}"]
  ingress_rules       = ["ssh-tcp","all-icmp"]
  egress_rules        = ["all-all"]

  tags = local.tags
}

module "security_group_web" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "web-ec2-sg"
  description = "Security group for web EC2 instance"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks = ["10.0.0.0/16"]
  ingress_rules       = ["http-80-tcp","all-icmp","ssh-tcp"]
  egress_rules        = ["all-all"]
  tags = local.tags
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "sheda-mac"
  public_key = var.public-key
}