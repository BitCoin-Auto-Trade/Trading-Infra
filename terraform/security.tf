# DB 서버 SG (룰 없음)
resource "aws_security_group" "db_sg" {
  name        = "${var.project_tag}-db-sg"
  description = "Allow SSH, PostgreSQL, Redis from Airflow + Bastion"
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Airflow SG (룰 없음)
resource "aws_security_group" "airflow_sg" {
  name        = "${var.project_tag}-airflow-sg"
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

# SSH to Airflow from your IP
resource "aws_security_group_rule" "airflow_ssh_from_your_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.airflow_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "SSH from your IP"
}

# Web UI to Airflow from your IP
resource "aws_security_group_rule" "airflow_webui_from_your_ip" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.airflow_sg.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "Web UI (optional)"
}

# airflow → db(Postgres)
resource "aws_security_group_rule" "db_postgres_from_airflow" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.airflow_sg.id
  description              = "Postgres from Airflow SG"
}

# airflow → redis
resource "aws_security_group_rule" "db_redis_from_airflow" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.airflow_sg.id
  description              = "Redis from Airflow SG"
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