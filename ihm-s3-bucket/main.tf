provider "aws" {
    profile = "ihm" 
    region = "us-east-1"
}


variable "s3input" {
    type = string
    description = "name the s3 bucket"
}

resource "aws_s3_bucket" "rlunabucket" {
    bucket = "my-tf-test-bucket-moon"
    acl = "private"
    tags = {
        Name = var.s3input
    }
}


output "s3name" {
    value = aws_s3_bucket.rlunabucket.id
}