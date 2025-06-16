resource "aws_instance" "db_server" {
  ami           = "ami-0662f4965dfc70aca"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "${var.project_tag}-db-server"
  }

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # 시간대 설정
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

    # 기본 패키지 업데이트
    apt-get update -y

    # 필수 패키지 설치
    apt-get install -y docker.io git curl

    # docker-compose 설치
    curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    # 도커 자동 실행
    systemctl start docker
    systemctl enable docker

    # docker 권한 부여
    usermod -aG docker ubuntu
  EOF
}
