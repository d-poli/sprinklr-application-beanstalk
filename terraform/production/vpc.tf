/*
  VPC Definition
*/

resource "aws_vpc" "nodejs_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.stack_name}-vpc"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}

/*
 Internet Gateway
*/

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"
     tags {
        Name = "${var.stack_name}-igw"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}


/*
  Public Subnets
*/
resource "aws_subnet" "subnet-A-public" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    cidr_block = "${var.public_subnet_a_cidr}"
    availability_zone = "${var.aws_region}a"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.stack_name} Public Subnet A"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}

resource "aws_subnet" "subnet-C-public" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    cidr_block = "${var.public_subnet_c_cidr}"
    availability_zone = "${var.aws_region}c"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.stack_name} Public Subnet C"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}

resource "aws_route_table" "public-route-table" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "${var.stack_name} Public Route Table"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}



resource "aws_route_table_association" "associate-public-subnet-A-route-table" {
    subnet_id = "${aws_subnet.subnet-A-public.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}


resource "aws_route_table_association" "associate-public-subnet-C-route-table" {
    subnet_id = "${aws_subnet.subnet-C-public.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}

/*
  Private Subnet
*/


resource "aws_subnet" "subnet-A-private" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    cidr_block = "${var.private_subnet_a_cidr}"
    availability_zone = "${var.aws_region}a"

    tags {

        Name = "${var.stack_name} Private Subnet A"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"

    }
}


resource "aws_subnet" "subnet-C-private" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    cidr_block = "${var.private_subnet_c_cidr}"
    availability_zone = "${var.aws_region}c"

    tags {

        Name = "${var.stack_name} Private Subnet C"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}


/*
  Private subnet Route Table
*/


resource "aws_route_table" "private-route-table-A" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.natgw-a.id}"
    }

    tags {

        Name = "${var.stack_name} Private Subnet A"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}


resource "aws_route_table" "private-route-table-C" {
    vpc_id = "${aws_vpc.nodejs_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.natgw-c.id}"
    }

    tags {

        Name = "${var.stack_name} Private Subnet C"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
    }
}

/*
  Private subnet Route Table Association
*/

resource "aws_route_table_association" "associate-private-subnet-A-route-table" {
    subnet_id = "${aws_subnet.subnet-A-private.id}"
    route_table_id = "${aws_route_table.private-route-table-A.id}"
}


resource "aws_route_table_association" "associate-private-subnet-C-route-table" {
    subnet_id = "${aws_subnet.subnet-C-private.id}"
    route_table_id = "${aws_route_table.private-route-table-C.id}"
}


/*
  NAT Gateway
*/

resource "aws_nat_gateway" "natgw-a" {
  allocation_id = "${aws_eip.nat-a.id}"
  subnet_id     = "${aws_subnet.subnet-A-public.id}"
}

resource "aws_nat_gateway" "natgw-c" {
  allocation_id = "${aws_eip.nat-c.id}"
  subnet_id     = "${aws_subnet.subnet-C-public.id}"
}

/*

NAT Elastic IPS

*/

resource "aws_eip" "nat-a" {
    vpc = true
}

resource "aws_eip" "nat-c" {
    vpc = true
}
