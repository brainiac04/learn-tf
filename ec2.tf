data "aws_ami" "learn_tf_v_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
}
/*
data "template_file" "user_data"{
  template = "${file("/Users/velurinavya/Documents/CANADA/CAN-ME/Training/git/learn-tf/templates/user-data.sh")}"
}
*/
resource "aws_instance" "learn_tf_v_ec2" {
  ami           = data.aws_ami.learn_tf_v_ami.id
  security_groups = [aws_security_group.learn_tf_sg.id]
  associate_public_ip_address = true
  subnet_id     = aws_subnet.learn_tf_subnet.id
  key_name      = "learn_tf_v_key_pair"
  instance_type = "t4g.micro"
  provisioner "local-exec" {
    command = "echo 'Waiting for instance to initialize...' 'Instance is ready.' The instance IP is ${self.public_ip}"
    interpreter = ["bash", "-c"]
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Checking instance readiness...'",
      "echo 'Hello, World!' > hello.txt",
      "sudo apt update",
      "sudo apt install -y apache2 apache2-bin mime-support ssl-cert",
      "sudo systemctl start apache2"
    ]
    when = create  # Execute only during resource creation
    connection {
      type        = "ssh"
      user        = "ubuntu"  # Update SSH user as needed
      private_key = file("./learn_tf_v_key_pair.pem")  # Path to your SSH private key
      host        = self.public_ip
    }
  }
}
