# airflow 인스턴스용 EIP
resource "aws_eip" "airflow_eip" {
  domain = "vpc"
}

# airflow EIP를 airflow 인스턴스에 연결
resource "aws_eip_association" "airflow_eip_assoc" {
  instance_id   = aws_instance.airflow_server.id
  allocation_id = aws_eip.airflow_eip.id
}

# DB 인스턴스용 EIP
resource "aws_eip" "db_eip" {
  domain = "vpc"
}

# DB EIP를 db 인스턴스에 연결
resource "aws_eip_association" "db_eip_assoc" {
  instance_id   = aws_instance.db_server.id
  allocation_id = aws_eip.db_eip.id
}
