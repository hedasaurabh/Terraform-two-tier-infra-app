variable "public-ip" {
  type = string
  description = "public ip for whitelisting bastion host"
}

variable "aws-region" {
  type = string
  description = "AWS region to launch servers"
}
variable "AWS_ACCESS_KEY" {
  type = string
  description = "AWS ACCESS KEY"
}
variable "AWS_SECRET_KEY" {
  type = string
  description = "AWS Secret Key"
}

variable "vpc-name" {
    type = string
    description = "Desired VPC Name"
}

variable "public-key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDcWhHOuB7oMy44XImYeWburPQ3HZwmGAIaaZJQrBRZZ19MisRP2Rn8+slnVbR1NH7bw7g+19mEjKqoa0rp+la8lmcgF14sTKinP32aGJoMdzfhazb2MkBWJIbp+N5QUzVOnZkiBKc6PTdpgq2pTBkuGB790xgxpNVyQmevCo2Cck/XKUVaMdfgXsrJxViXFJhNrqvCaZ8AcQyjjz4ZKEoqdF0JdoJNR4VoZsVcZE79Kw1ARS7vn9zMZkTaDtyamW5mWsX4tsgg18Jaw9uHBnA7XOv1Uy3q+9CrfeoSwRvVzfZlJG55GxGf2W/xLA2+2i4BY9RlWB5NLT3GNgUNuf8WNORVYad756D2E3jPmyzHP9FrWtZaAe3nrfmESUNJB4z9/JcbFviOqS7iWJVudP8penI56yD0E284/Rg5ebt0Pz519eZNM6ZeCHpV+xf5pKOG/tZM0MAbk+zpiFYk7xbVp/2YgrN2byAcSeDuDYcqJj5xs9X3Eom69mux+ByfBkNpcsseEQejZt918VVTAb9hSksfiY+EHeTH6PR7Gr+eFriw4J3uUs2Yb1Mv3ffnqUxftbA8VMIhGScKBy+GXsyx0ynAd4fWBq0+9N4EqWY266h8xh3d24jx+D13nFJWyZ+Dw1BNqPX55WfblF3SNVWpOHVQUyHB8boZfT7AqF6MmQ== saurabhh@SaurabhH.local"
  description = "Desired AWS key pair"
}
