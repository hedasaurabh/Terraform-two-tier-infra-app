locals {
  name               = "ec2-web"
  user_data = <<-EOT
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y nginx
  sudo service nginx start
  EOT
#   multiple_instances = {
#     one = {
#       instance_type     = "t2.micro"
#       availability_zone = element(module.vpc.azs, 0)
#       subnet_id         = element(module.vpc.private_subnets, 0)
#     }
#     two = {
#       instance_type     = "t2.micro"
#       availability_zone = element(module.vpc.azs, 1)
#       subnet_id         = element(module.vpc.private_subnets, 1)
#     }
#   }
}


module "ec2_web_1" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 3.0"

  name = "${local.name}-1"

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = [module.security_group_web.security_group_id]
  user_data                   = local.user_data
#  user_data_base64            = base64encode(local.user_data)
  key_name                    = module.key_pair.key_pair_key_name
}

module "ec2_web_2" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 3.0"

  name = "${local.name}-2"

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  availability_zone           = element(module.vpc.azs, 1)
  subnet_id                   = element(module.vpc.private_subnets, 1)
  vpc_security_group_ids      = [module.security_group_web.security_group_id]
  user_data                   = local.user_data
#  user_data_base64            = base64encode(local.user_data)
  key_name                    = module.key_pair.key_pair_key_name
}

# module "ec2_multiple" {
#    source  = "terraform-aws-modules/ec2-instance/aws"
#    version = "~> 3.0"


#   for_each = local.multiple_instances

#   name = "${local.name}-multi-${each.key}"

#   ami                    = data.aws_ami.amazon_linux.id
#   instance_type          = each.value.instance_type
#   availability_zone      = each.value.availability_zone
#   subnet_id              = each.value.subnet_id
#   vpc_security_group_ids = [module.security_group_web.security_group_id]
#   key_name               = module.key_pair.key_pair_key_name
#   tags = local.tags
#   user_data_base64 = base64encode(local.user_data)
# }