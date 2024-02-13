terraform {
 backend "s3" {
    bucket = "learn-tf-veera"
    key = "learntf.tfstate"
    region = "us-east-1"
 }
}