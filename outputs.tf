output "vpc_id_o" {
  value = aws_vpc.learn_tf_vpc.id
}

output "ami_id" {
  value = data.aws_ami.learn_tf_v_ami.id
}