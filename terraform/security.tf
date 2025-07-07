# DB 서버 SG (룰 없음)
resource "aws_security_group" "db_sg" {
  name        = "${var.project_tag}-db-sg"
  description = "Allow SSH, PostgreSQL, Redis from getbitcoin + Bastion"
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# getbitcoin SG (룰 없음)
resource "aws_security_group" "getbitcoin_sg" {
  name        = "${var.project_tag}-getbitcoin-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SSH to DB from your IP
resource "aws_security_group_rule" "db_ssh_from_your_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.db_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "SSH from your IP"
}

# SSH to getbitcoin from your IP
resource "aws_security_group_rule" "getbitcoin_ssh_from_your_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.getbitcoin_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "SSH from your IP"
}

# Web UI to getbitcoin from your IP
resource "aws_security_group_rule" "getbitcoin_webui_from_your_ip" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.getbitcoin_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "Web UI (optional)"
}

# getbitcoin → db(Postgres)
resource "aws_security_group_rule" "db_postgres_from_getbitcoin" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.getbitcoin_sg.id
  description              = "Postgres from getbitcoin SG"
}

# getbitcoin → redis
resource "aws_security_group_rule" "db_redis_from_getbitcoin" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.getbitcoin_sg.id
  description              = "Redis from getbitcoin SG"
}

resource "aws_security_group_rule" "db_postgres_from_your_ip" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.db_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "PostgreSQL from your IP"
}

resource "aws_security_group_rule" "redis_from_your_ip" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = aws_security_group.db_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "Redis from your IP"
}