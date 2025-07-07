resource "aws_eip" "getbitcoin_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "getbitcoin_eip_assoc" {
  instance_id   = aws_instance.getbitcoin_server.id
  allocation_id = aws_eip.getbitcoin_eip.id
}

resource "aws_eip" "db_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "db_eip_assoc" {
  instance_id   = aws_instance.db_server.id
  allocation_id = aws_eip.db_eip.id
}
