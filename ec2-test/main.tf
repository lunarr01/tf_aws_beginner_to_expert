provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


variable "inputec2name" {
    type = string
    description = "give ec2 instance a name"
}

resource "aws_instance" "ec2-test" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    tags = {
        Name = var.inputec2name
    }
}


output "ec2name" {
    value = aws_instance.ec2-test.id
}