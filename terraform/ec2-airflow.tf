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

    # 기본 업데이트
    apt-get update -y
    apt-get install -y software-properties-common

    # python3.12 + venv + pip 설치
    apt-get install -y python3.12 python3.12-venv python3-pip

    # python3, pip 기본 명령어에 연결
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

    # docker + git + curl
    apt-get install -y docker.io git curl

    # docker 설정
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu

    # docker-compose 설치
    curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  EOF

}