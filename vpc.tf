resource "aws_vpc" "learn_tf_vpc" {
  cidr_block = "192.168.54.0/24"
  tags = {
    env  = "dev"
    Name = "learn_tf_vpc"
  }
}
/*
data "aws_vpc" "learn_tf_vpc_d" {
 id = var.vpc_id
filter {
    name   = "tag:Name"
    values = ["learn_tf_vpc_v"]
}
}
*/

resource "aws_subnet" "learn_tf_subnet" {
  cidr_block = "192.168.54.0/26"
  vpc_id     = aws_vpc.learn_tf_vpc.id
  tags = {
    env  = "dev"
    Name = "learn_tf_subnet_public"
  }
}
resource "aws_subnet" "learn_tf_subnet_p" {
  cidr_block = "192.168.54.64/26"
  vpc_id     = aws_vpc.learn_tf_vpc.id
  tags = {
    env  = "dev"
    Name = "learn_tf_subnet_private"
  }
}
resource "aws_internet_gateway" "learn_tf_ig" {
  vpc_id = aws_vpc.learn_tf_vpc.id
  tags = {
    env  = "dev"
    Name = "learn_tf_ig"
  }
}

resource "aws_security_group" "learn_tf_sg" {
  name = "learn_tf_sg"
  vpc_id = aws_vpc.learn_tf_vpc.id
  tags = {
    env  = "dev"
    Name = "learn_tf_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "learn_tf_isgr_ssh" {
  security_group_id = aws_security_group.learn_tf_sg.id
  cidr_ipv4   = "184.147.23.192/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  tags = {
    env  = "dev"
    Name = "learn_tf_isgr_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "learn_tf_isgr_http" {
  security_group_id = aws_security_group.learn_tf_sg.id
  cidr_ipv4   = "184.147.23.192/32"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  tags = {
    env  = "dev"
    Name = "learn_tf_isgr_http"
  }
}

resource "aws_vpc_security_group_egress_rule" "learn_tf_esgr" {
  security_group_id = aws_security_group.learn_tf_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
  tags = {
    env  = "dev"
    Name = "learn_tf_esgr"
  }
}

resource "aws_route_table" "learn_tf_route_table" {
  vpc_id = aws_vpc.learn_tf_vpc.id
  tags = {
    env  = "dev"
    Name = "learn_tf_route_table"
  }
}

resource "aws_route" "learn_tf_route" {
  route_table_id = aws_route_table.learn_tf_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.learn_tf_ig.id
}

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.learn_tf_subnet.id
  route_table_id = aws_route_table.learn_tf_route_table.id
}