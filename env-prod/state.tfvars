terraform {
  backend "s3" {
    bukcet ="terraform-74"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}