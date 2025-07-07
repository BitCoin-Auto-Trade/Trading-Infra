resource "aws_instance" "db_server" {
  ami           = "ami-0662f4965dfc70aca"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  root_block_device {
    volume_size = 12
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_tag}-db-server"
  }
}
