terraform {
  backend "s3" {
    bucket  =  "mohana6-bucket"
    key     =  "errorbudget-terraform-dev-tfstate/vector-main-dev.tfstate"
    region  =  "us-east-1"
    encrypt = true
    acl     = "private"
    
  }
}