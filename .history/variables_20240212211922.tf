variable vpc_id {
    default = aws_vpc.learn_tf_vpc.id
    type = "string"
    description = "this is the primary vpc for learning tf"
}