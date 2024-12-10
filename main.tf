terraform {
  backend "s3" {
    bucket         = "isc-anasty-state"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "anasty-lock-table"
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "anasty_vpc" {
  cidr_block = "172.30.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_internet_gateway" "anasty_gateway" {
  vpc_id = aws_vpc.anasty_vpc.id
}

resource "aws_subnet" "anasty_subnet" {
  vpc_id     = aws_vpc.anasty_vpc.id
  cidr_block = "172.30.0.0/24"
}

resource "aws_subnet" "anasty_subnet_ipv6" {
  vpc_id            = aws_vpc.anasty_vpc.id
  cidr_block        = "172.30.1.0/24"
  availability_zone = "us-west-1c"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.anasty_vpc.ipv6_cidr_block, 8, 1)
}

resource "aws_route_table" "anasty_route_table" {
  vpc_id = aws_vpc.anasty_vpc.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.anasty_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.anasty_gateway.id
}

resource "aws_route_table_association" "anasty_table_association" {
  subnet_id      = aws_subnet.anasty_subnet.id
  route_table_id = aws_route_table.anasty_route_table.id
}

resource "aws_route_table_association" "anasty_table_association_ipv6" {
  subnet_id      = aws_subnet.anasty_subnet_ipv6.id
  route_table_id = aws_route_table.anasty_route_table.id
}

resource "aws_security_group" "anasty_security_group" {
  vpc_id = aws_vpc.anasty_vpc.id
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = aws_security_group.anasty_security_group.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http" {
  security_group_id = aws_security_group.anasty_security_group.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https" {
  security_group_id = aws_security_group.anasty_security_group.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "back_anasty" {
  ami                    = "ami-0657605d763ac72a8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.anasty_security_group.id]
  key_name               = "masternode"
  subnet_id              = aws_subnet.anasty_subnet.id
}

resource "aws_eip" "back_anasty_eip" {
  instance = aws_instance.back_anasty.id
}

output "instance_ip" {
  value = aws_eip.back_anasty_eip.public_ip
}
resource "local_file" "instance_ip_file" {
  content  = aws_eip.back_anasty_eip.public_ip
  filename = "${path.module}/instance_ip.txt"
}