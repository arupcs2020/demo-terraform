####################################
# PRIVATE SUBNET
####################################

resource "aws_subnet" "private1" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 110 )}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1a"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Private Subnet 1"
    )
)}"
}

resource "aws_subnet" "private2" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 120 )}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1b"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Private Subnet 2"
    )
)}"
    
}


resource "aws_subnet" "private_lb1" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 130 )}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1a"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Private LB Subnet 1"
    )
)}"
}

resource "aws_subnet" "private_lb2" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 140 )}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1a"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Private LB Subnet 2"
    )
)}"
}

# PUBLIC SUBNET

resource "aws_subnet" "public1" {
    vpc_id = "${aws_vpc.default.id}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1b"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 10 )}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Public Subnet 1"
    )
)}"
}

resource "aws_subnet" "public2" {
    vpc_id = "${aws_vpc.default.id}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1a" 
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 20 )}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Public Subnet 2"
    )
)}"
}


resource "aws_subnet" "public_lb1" {
    vpc_id = "${aws_vpc.default.id}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1a"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 30 )}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Public LB Subnet 1"
    )
)}"
}

resource "aws_subnet" "public_lb2" {
    vpc_id = "${aws_vpc.default.id}"
    availability_zone = "${element(split("-",var.region), 0)}-${element(split("-",var.region), 1)}-1b"
    cidr_block = "${cidrsubnet("${var.vpc_cidr}", 8, 40 )}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Public LB Subnet 2"
    )
)}"
}

####################################
# ROUTE TABLE FOR PUBLIC TO IGW
####################################

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.this.id}"
    }
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Public Subnet Route"
    )
)}"
}
resource "aws_route_table_association" "public1" {
    subnet_id = "${aws_subnet.public1.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public2" {
    subnet_id = "${aws_subnet.public2.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "lb_public1" {
    subnet_id = "${aws_subnet.public_lb1.id}"
    route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "lb_public2" {
    subnet_id = "${aws_subnet.public_lb2.id}"
    route_table_id = "${aws_route_table.public.id}"
}

####################################
# ROUTE TABLE FOR PRIVATE TO NAT
####################################

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.gw.id}"
    }
    route {
        cidr_block = "192.168.48.0/20"
        network_interface_id = "${aws_instance.ip_sec_server.primary_network_interface_id}"
    }
    route {
        cidr_block = "192.168.64.0/18"
        network_interface_id = "${aws_instance.ip_sec_server.primary_network_interface_id}"
    }
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Private Subnet Route"
    )
)}"
}
resource "aws_route_table_association" "private1" {
    subnet_id = "${aws_subnet.private1.id}"
    route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "private2" {
    subnet_id = "${aws_subnet.private2.id}"
    route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "lb_private1" {
    subnet_id = "${aws_subnet.private_lb1.id}"
    route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "lb_private2" {
    subnet_id = "${aws_subnet.private_lb2.id}"
    route_table_id = "${aws_route_table.private.id}"
}

