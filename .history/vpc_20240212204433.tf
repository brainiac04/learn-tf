resource "aws_vpc" "learn_tf_vpc" {
  cidr_block = "192.168.54.0/24"
  tags = {
    env = "dev"
    Name = "learn_tf_vpc_v"
  }
}