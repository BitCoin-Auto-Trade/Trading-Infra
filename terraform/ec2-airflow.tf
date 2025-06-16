resource "aws_instance" "airflow_server" {
  ami           = "ami-0662f4965dfc70aca"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.airflow_sg.id]

  tags = {
    Name = "${var.project_tag}-airflow-server"
  }

  user_data = <<-EOF
    #!/bin/bash
    set -eux

    apt-get update -y

    # 필수 패키지만 설치
    apt-get install -y docker.io git curl

    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu

    # docker-compose 설치
    curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  EOF

}