resource "aws_internet_gateway" "this" {
    vpc_id = "${aws_vpc.default.id}"
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public1.id}"
}
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_eip" "ipsec" {
    instance = "${aws_instance.ip_sec_server.id}"
    vpc = true
}
