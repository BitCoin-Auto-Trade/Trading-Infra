resource "aws_instance" "airflow_server" {
  ami           = "ami-0662f4965dfc70aca"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.airflow_sg.id]

  root_block_device {
    volume_size = 18
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_tag}-airflow-server"
  }
}
