variable "aws_region" {
  description = "Region for the VPC"
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.40.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.40.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "10.40.2.0/24"
}

variable "ami" {
  description = "Amazon Linux2 AMI"
  default = "ami-0332cf924587fe3fc"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/core/.ssh/id_rsa.pub"
}
