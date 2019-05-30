provider "aws" {
  region = "us-east-1"
}
terraform {
    backend "s3" {
        bucket = "terraform-state-lab10"
        key = "workspace/vpc/vpc-vm"
        region = "us-east-1"
    }
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}
resource "aws_instance" "ubuntu" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.subnet1.id}"
  key_name = "ubuntu"
  tags {
      Billing = "IT", 
      Name = "james-ubuntu"
  }
  vpc_security_group_ids  = ["${aws_security_group.asg1.id}"]
}

resource "aws_eip" "external" {
  instance = "${aws_instance.ubuntu.id}"
  vpc = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_security_group" "asg1" {
    name = "asg-1"
    description = "allow all"
    vpc_id = "${aws_vpc.vpc1.id}"
    ingress {
    
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    
    cidr_blocks =  ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }

}
