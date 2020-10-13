provider "aws" {
    profile = "ihm"
    region = "us-east-1"
}


variable "vpcinput" {
    type = string
    description = "input vpc name"
}


resource "aws_vpc" "challenge1vpc" {
    cidr_block = "192.168.0.0/24"
    tags = {
        Name = var.vpcinput
    }
}


output "vpcid" {
    value = aws_vpc.challenge1vpc.id
}