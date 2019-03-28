data "aws_ami" "stagebox_ami" {
    most_recent = true
    filter {
        name   = "name"
        values = ["${var.ami_stage}*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["959197153948"]
}

resource "aws_instance" "box_server" {
  ami = "${data.aws_ami.stagebox_ami.id}"
  instance_type = "t2.small"
  key_name = "${aws_key_pair.terraform_key.key_name}"
  user_data = <<-EOF
    #cloud-config
    runcmd:
    - echo search ${var.domain_name} >> /etc/resolv.conf
    - iptables -t nat -A POSTROUTING -o eth0 -s ${var.vpc_cidr} -j MASQUERADE
    EOF
  vpc_security_group_ids = ["${aws_security_group.stagebox_sg.id}","${aws_security_group.common.id}"]
  subnet_id = "${aws_subnet.public1.id}"
  associate_public_ip_address = true
  source_dest_check = false
  tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Bastion Server"
    )
)}"
}
resource "aws_instance" "ip_sec_server" {
    ami = "ami-07e5625837860ce2c" # this is a special ami preconfigured to do NAT
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.terraform_key.key_name}"
    vpc_security_group_ids = ["${aws_security_group.ip_sec.id}","${aws_security_group.common.id}"]
    subnet_id = "${aws_subnet.public1.id}"
    associate_public_ip_address = true
    source_dest_check = false
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} IPsec Server"
    )
    )}"
}
