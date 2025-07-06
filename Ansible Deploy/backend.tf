terraform {
  backend "s3" {
    bucket = "your-unique-bucket-name"
    key    = "backend/terraform.tfstate"
    region = "your-region"
  }
}