provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


variable "inputdbname" {
    type = string
    description = "give ec2 instance a name"
}

resource "aws_instance" "db" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    tags = {
        Name = var.inputdbname
    }
}


resource "aws_instance" "web" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    tags = {
        Name = "Web Server"
    }
    # Example of needing the DB server to be created before the web server
    depends_on = [aws_instance.db]
}


output "dbname" {
    value = aws_instance.db.id
}