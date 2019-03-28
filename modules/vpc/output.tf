#stagebox ami id


output "r53_id" {
  value = "${aws_route53_zone.this.id}"
}

output "private_subnet1" {
  value = "${aws_subnet.private1.id}"
} 
output "private_subnet2" {
  value = "${aws_subnet.private2.id}"
}

output "private_subnet_lb1" {
  value = "${aws_subnet.private_lb1.id}"
}
output "private_subnet_lb2" {
  value = "${aws_subnet.private_lb2.id}"
}
output "public_subnet1" {
  value = "${aws_subnet.public1.id}"
}
output "public_subnet2" {
  value = "${aws_subnet.public2.id}"
}
output "private_sub1" {
  value = "${aws_subnet.private1.id}"
}
output "private_sub2" {
  value = "${aws_subnet.private2.id}"
}

output "public_sub1" {
  value = "${aws_subnet.public1.id}"
}
output "public_sub2" {
  value = "${aws_subnet.public2.id}"
}

output "private_lb_sub1" {
  value = "${aws_subnet.private_lb1.id}"
}
output "private_lb_sub2" {
  value = "${aws_subnet.private_lb2.id}"
}
output "public_lb_sub1" {
  value = "${aws_subnet.public_lb1.id}"
}
output "public_lb_sub2" {
  value = "${aws_subnet.public_lb2.id}"
}

output "common_sg" {
  value = "${aws_security_group.common.id}"
}
output "nat_sg" {
  value = "${aws_security_group.nat_sg.id}"
}
output "box_server_public_ip" {
  value = "${aws_instance.box_server.public_ip}"
}
output "nat_public_ip" {
  value = "${aws_instance.ip_sec_server.public_ip}"
}
output "aws_vpc_id" {
value = "${aws_vpc.default.id}"
}
