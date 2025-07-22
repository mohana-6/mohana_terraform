terraform {
  backend "s3" {
    bucket  =  "errorbudget-s3"
    key     =  "errorbudget-terraform-tfstate/vector-star-dev.tfstate"
    region  =  "us-east-1"
    encrypt = true
    acl     = "private"
  }
}