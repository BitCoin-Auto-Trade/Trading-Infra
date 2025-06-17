resource "aws_s3_bucket" "bitcoin_data" {
  bucket = "lsj-bitcoin-data"
  force_destroy = true
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-lsj"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}