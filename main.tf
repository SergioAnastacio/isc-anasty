terraform {
  backend "s3" {
    bucket         = "isc-anasty-state"
    key            = "terraform.tfstate"
    region         = "us-west-1"  
    dynamodb_table = "anasty-lock-table"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "anasty_vpc" {
  cidr_block = var.vpc.cidr_block
}

resource "aws_internet_gateway" "anasty_gateway" {
  vpc_id = aws_vpc.anasty_vpc.id
  
}

resource "aws_subnet" "anasty_subnet" {
  vpc_id     = aws_vpc.anasty_vpc.id
  cidr_block = var.subnet.cidr_block
}

resource "aws_route_table" "anasty_route_table" {
  vpc_id = aws_vpc.anasty_vpc.id
}

resource "aws_route_table_association" "anasty_table_association" {
  subnet_id      = aws_subnet.anasty_subnet.id
  route_table_id = aws_route_table.anasty_route_table.id
}

resource "aws_security_group" "anasty_security_group" {
  vpc_id = aws_vpc.anasty_vpc.id
}

resource "aws_security_group_rule" "anasty_vpc_sg_rule" {
  security_group_id = aws_security_group.anasty_security_group.id
  type              = var.security_group_rule.type
  from_port         = var.security_group_rule.from_port
  to_port           = var.security_group_rule.to_port
  protocol          = var.security_group_rule.protocol
  cidr_blocks       = var.security_group_rule.cidr_blocks
}

resource "aws_instance" "back_anasty" {
  ami           = var.ec2.ami
  instance_type = var.ec2.instance_type
  vpc_security_group_ids = [aws_security_group.anasty_security_group.id]
  key_name               = var.key_name
  subnet_id              = aws_subnet.anasty_subnet.id
}
resource "aws_eip" "back_anasty_eip" {
  instance = aws_instance.back_anasty.id
}

output "instance_ip" {
  value = aws_eip.back_anasty_eip.public_ip
}