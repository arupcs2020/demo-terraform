
# Define our VPC
resource "aws_vpc" "sapient_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "sapient-vpc"
  }
}

