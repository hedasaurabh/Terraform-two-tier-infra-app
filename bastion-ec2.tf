locals {
  availability_zone = "${var.aws-region}a"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
module "ec2-bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "ec2-bastion"

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  availability_zone           = local.availability_zone
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [module.security_group_bastion.security_group_id]
  associate_public_ip_address = true
  key_name                    = module.key_pair.key_pair_key_name
  tags = local.tags
}