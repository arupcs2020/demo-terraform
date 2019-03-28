provider "aws" {
  region = "${var.region}"
}
module "vpc" {
  source = "../../modules/vpc"
  region = "${var.region}"
  vpc_cidr = "${var.vpc_cidr}"
  env_name = "${var.env_name}"
  domain_name = "${var.domain_name}"
  key_name = "${var.key_name}"
  ami_stage = "${var.ami_stage}"
}
