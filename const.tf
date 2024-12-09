//Config variables

variable "region" {
  description = "AWS region"
  type = string
  default="us-west-1"
}

variable "bucket" {
  description = "Name of the S3 bucket"
  type = string
  default = "isc-anasty-state"
}

variable "Key_terraform_state" {
  description = "Name of the key"
  type = string
  default = "terraform.tfstate"
}

variable "dynamodb_table" {
  description = "Name of the DynamoDB table"
  type = string
  default = "anasty-lock-table"
}

// Key pair name AWS EC2
variable "key_name"{
  description = "value of the key"
  type = string
  default = "masternode"
}

variable "ec2" {
  description = "EC2 instance configuration"
  type = object({
    ami           = string
    instance_type = string
  })
  default = {
    // Ubuntu 20.04 LTS
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
  }
}

//Config variables

variable "vpc" {
  description = "VPC configuration"
  type = object({
    cidr_block = string
  })
  default = {
    cidr_block = "10.0.0.0/16"
  }
}

variable "subnet" {
  description = "Subnet configuration"
  type = object({
    cidr_block = string
  })
  default = {
    cidr_block = "10.0.1.0/24"
  }
}
variable "route_table" {
  description = "Route table configuration"
  type = object({
    vpc_id = string
  })
  default = {
    vpc_id = "vpc-12345678"
  }
}
variable "table_association" {
  description = "Route table association configuration"
  type = object({
    subnet_id      = string
    route_table_id = string
  })
  default = {
    subnet_id      = "subnet-12345678"
    route_table_id = "rtb-12345678"
  } 
}

variable "security_group" {
  description = "Security group configuration"
  type = object({
    name = string
  })
  default = {
    name = "example"
  }
}

variable "security_group_rule" {
  description = "Security group rule configuration"
  type = object({
    type              = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_blocks       = list(string)
  })
  default = {
    type              = "ingress"
    from_port         = 3000
    to_port           = 3000
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
}
