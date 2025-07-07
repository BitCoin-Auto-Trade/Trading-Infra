output "getbitcoin_instance_id" {
  description = "EC2 instance ID for getbitcoin"
  value       = aws_instance.getbitcoin_server.id
}

output "db_instance_id" {
  description = "EC2 instance ID for DB Server"
  value       = aws_instance.db_server.id
}

output "getbitcoin_public_ip" {
  description = "Elastic IP for getbitcoin server"
  value       = aws_eip.getbitcoin_eip.public_ip
}

output "db_public_ip" {
  description = "Elastic IP for DB server"
  value       = aws_eip.db_eip.public_ip
}

output "s3_data_bucket" {
  description = "S3 bucket for Bitcoin data"
  value       = aws_s3_bucket.bitcoin_data.id
}

output "s3_tfstate_bucket" {
  description = "S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_lock_table" {
  description = "DynamoDB table for Terraform state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}
