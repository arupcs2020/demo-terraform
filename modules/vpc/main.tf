locals {
  common_tags = {
      "${var.env_name}_vpc" = ""
  }
}


resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} VPC"
    )
)}"
}

resource "aws_route53_zone" "this" {
  name   = "${var.domain_name}"
  vpc_id = "${aws_vpc.default.id}"
}

