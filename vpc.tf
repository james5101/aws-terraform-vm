terraform {
  backend "s3" {
    bucket = "terraform-state-lab10"
    key    = "workspace/vpc/vpc-vm"
    region = "us-east-1"
  }
}

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vm_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc1.id}"
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  depends_on = ["aws_internet_gateway.gw"]

  tags = {
    Name = "main_vm_subnet"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = "${aws_vpc.vpc1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "test-env-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.route-table.id}"
}
