# Terraform-two-tier-infra-app
This repo creates a two-tier architecture on Amazon Web services using Terraform. It is built with below terraform modules:
1. terraform-aws-vpc
2. terraform-aws-ec2
3. terraform-aws-alb
4. terraform-aws-security-group
5. terraform-aws-modules/key-pair/aws

## Prerequisites
1. Install Terraform
2. AWS Access and Secret key are provided to in `terraform.tfvars.json`
3. Public key is provided to `terraform.tfvars.json` file to access the Bastion Host over SSH.

## Usage examples
After you run `terraform apply` on this configuration, it will
automatically output the DNS address of the ELB along with few other outputs. After your instance
registers, this should respond with the default nginx web page.

To run, configure your AWS provider as described in 

https://www.terraform.io/docs/providers/aws/index.html

Run with a command like this:

```
terraform apply -var 'AWS_ACCESS_KEY={your_aws_access_key}' \
   -var 'public-key={your_public_key}' \
   -var 'AWS_SECRET_KEY={your_aws_secret_key}'
```

