resource "aws_eip" "airflow_eip" {
  instance = aws_instance.airflow_server.id
  domain   = "vpc"
}

resource "aws_eip" "db_eip" {
  instance = aws_instance.db_server.id
  domain   = "vpc"
}
