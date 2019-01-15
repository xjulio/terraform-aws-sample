resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "terraform-vpcBB"
    }
}

/*
  Public Subnet
*/
resource "aws_subnet" "public-subnet-a" {
    vpc_id = "${aws_vpc.default.id}"
	map_public_ip_on_launch = true

    cidr_block = "${var.public_subnet_cidr-a}"
    availability_zone = "${var.aws_region}a"
	
    tags {
        Name = "Public Subnet a"
    }
}

resource "aws_subnet" "public-subnet-b" {
    vpc_id = "${aws_vpc.default.id}"
    map_public_ip_on_launch = true

    cidr_block = "${var.public_subnet_cidr-b}"
    availability_zone = "${var.aws_region}b"

    tags {
        Name = "Public Subnet b"
    }
}

resource "aws_subnet" "public-subnet-c" {
    vpc_id = "${aws_vpc.default.id}"
    map_public_ip_on_launch = true

    cidr_block = "${var.public_subnet_cidr-c}"
    availability_zone = "${var.aws_region}c"

    tags {
        Name = "Public Subnet c"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    
    tags {
        Name = "vpcBB Gateway"
    }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}