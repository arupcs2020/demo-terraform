####################################
# SECURITY GROUP FOR PRIVATE SUBNET
####################################

resource "aws_security_group" "common" {
    name = "${var.env_name}_common_sg"
    description = "Allow Traffic for All Internal Network"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.48.0/20"]
  }
ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["o.10.64.0/18"]
  }
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
egress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
 }
    vpc_id = "${aws_vpc.default.id}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} Common SG"
    )
)}"
}


resource "aws_security_group" "ip_sec" {
    name        = "${var.env_name}-stage-ipsec"
    description = "Site to Site"
    vpc_id      = "${aws_vpc.default.id}"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = [""]
    }

    ingress {
        from_port       = 4500
        to_port         = 4500
        protocol        = "udp"
        cidr_blocks     = [""]
    }

    ingress {
        from_port       = 500
        to_port         = 500
        protocol        = "udp"
        cidr_blocks     = ["]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "${var.env_name} IP-SEC"
    }
}



####################################
# SECURITY GROUP FOR NAT SERVERS
####################################

resource "aws_security_group" "nat_sg" {
    name = "nat_sg"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.private1.cidr_block}"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.private2.cidr_block}"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.private_lb1.cidr_block}"]
    }
     ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.private_lb2.cidr_block}"]
    }
    

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.public1.cidr_block}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.public2.cidr_block}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.public_lb1.cidr_block}"]
    }
     ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.public_lb2.cidr_block}"]
    }
    

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} NAT SG"
    )
)}"
}

####################################
# SECURITY GROUP FOR STAGEBOX
####################################

resource "aws_security_group" "stagebox_sg" {
    name = "stagebox_sg"
    description = "Allow access to private and public server"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    vpc_id = "${aws_vpc.default.id}"
    tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.env_name} STAGEBOX SG"
    )
)}"
}
