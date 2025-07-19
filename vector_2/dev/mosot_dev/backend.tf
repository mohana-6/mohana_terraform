terraform {
  backend "s3" {
    bucket  =  "errorbudget-s3"
    key     =  "errorbudget-terraform-tfstate/vector-mosot-dev.tfstate"
    region  =  "us-east-1"
    encrypt = true
    acl     = "private"
  }
}