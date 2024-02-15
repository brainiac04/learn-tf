resource "aws_vpc" "learn_tf_vpc" {
  cidr_block = "192.168.54.0/24"
  tags = {
    env = "dev"
    Name = "learn_tf_vpc_v"
  }
}

resource "aws_subnet" "learn_tf_subnet" {
  cidr_block = "192.168.54.0/26"
  vpc_id = aws_vpc.learn_tf_vpc
}