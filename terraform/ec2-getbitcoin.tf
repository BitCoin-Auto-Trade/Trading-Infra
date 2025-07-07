resource "aws_instance" "getbitcoin_server" {
  ami           = "ami-0662f4965dfc70aca"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.getbitcoin_sg.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_tag}-getbitcoin-server"
  }
}
