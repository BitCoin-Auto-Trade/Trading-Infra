resource "aws_eip" "airflow_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "airflow_eip_assoc" {
  instance_id   = aws_instance.airflow_server.id
  allocation_id = aws_eip.airflow_eip.id
}

resource "aws_eip" "db_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "db_eip_assoc" {
  instance_id   = aws_instance.db_server.id
  allocation_id = aws_eip.db_eip.id
}
