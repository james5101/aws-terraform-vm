output "vpc_id" {
  value = "${aws_vpc.vpc1.id}"
}

output "subnet_id" {
  value = "${aws_subnet.subnet1.id}"
}


output "public_id" {
  value = "${aws_eip.external.public_ip}"
}
