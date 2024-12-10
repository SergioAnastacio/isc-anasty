//Config variables

variable "region" {
  description = "AWS region"
  type = string
  default="us-west-1"
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
    // Ubuntu 24.04 LTS(hvm:ssd) (x64 (x86))
    ami           = "ami-0657605d763ac72a8" //us-west-1
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
    cidr_block = "172.30.0.0/16"
  }
}

variable "subnet" {
  description = "Subnet configuration"
  type = object({
    cidr_block = string
  })
  default = {
    cidr_block = "172.30.0.0/24"
    availability_zone = "us-west-1b"
  }
}

variable "subnet_ipv6" {
  description = "IPv6 Subnet configuration"
  type = object({
    cidr_block = string
    availability_zone = string
  })
  default = {
    cidr_block = "172.30.1.0/24"
    availability_zone = "us-west-1c"
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
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
}
