provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


variable "number_of_servers" {
    type = number
}


resource "aws_instance" "ec2" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    #creates 3 instances
    count = var.number_of_servers
}