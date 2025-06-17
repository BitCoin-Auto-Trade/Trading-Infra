resource "aws_security_group" "db_sg" {
  name        = "${var.project_tag}-db-sg"
  description = "Allow SSH, PostgreSQL, Redis from Airflow + Bastion"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "airflow_sg" {
  name        = "${var.project_tag}-airflow-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "Web UI (optional)"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
