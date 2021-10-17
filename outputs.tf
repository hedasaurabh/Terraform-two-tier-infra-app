output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_ip" {
  description = "The public IP address assigned to the instance"
  value = module.ec2-bastion.public_ip
}
output "public_dns" {
  description = "The public DNS name assigned to the instance"
  value = module.ec2-bastion.public_dns
  
}

output "lb-dns_name" {
  value = module.alb.lb_dns_name
}

# output "ec2_multiple" {
#   description = "The full output of the `ec2_module` module"
#   value       = module.ec2_multiple
# }
