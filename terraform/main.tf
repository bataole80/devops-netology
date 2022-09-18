data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  web_instance_type_map = {
    stage = "t3.micro"
    prod = "t2.micro"
  }
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
  instances = {
    "t3.micro" = data.aws_ami.ubuntu.id
    "t3.large" = data.aws_ami.ubuntu.id
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web_instance_type_map[terraform.workspace]
  count = local.web_instance_count_map[terraform.workspace]

  tags = {
    Name = "HelloUbuntu"
  }
}

resource "aws_instance" "web1" {
  for_each = local.instances
  ami = each.value
  instance_type = each.key
  
}

data "aws_caller_identity" "current" {}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

data "aws_region" "current" {}

provider "aws" {
  region = "eu-west-2"
}



