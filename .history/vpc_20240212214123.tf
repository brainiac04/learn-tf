resource "aws_vpc" "learn_tf_vpc" {
  cidr_block = "192.168.54.0/24"
  tags = {
    env = "dev"
    Name = "learn_tf_vpc_v"
  }
}

data "aws_vpc" "learn_tf_vpc_d" {
 id = var.vpc_id
 default = false
}

resource "aws_subnet" "learn_tf_subnet" {
  cidr_block = "192.168.54.0/26"
  vpc_id = var.vpc_id
}

resource "aws_subnet" "learn_tf_subnet_p" {
 cidr_block = "192.168.54.64/26"
 vpc_id = var.vpc_id
}