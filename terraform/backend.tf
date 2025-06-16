terraform {
  backend "s3" {
    bucket         = "terraform-state-lsj"       
    key            = "infra/terraform.tfstate"   
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-lock"          
    encrypt        = true
  }
}
