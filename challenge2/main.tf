provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


variable "ingressrules" {
    type = list(number)
    default = [80,443]
}


variable "egressrules" {
    type = list(number)
    default = [80,443]
}


resource "aws_instance" "dbserver" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    tags = {
        Name = "db-server-luna-test"
    }
}


resource "aws_instance" "webserver" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.allow_http.name]
    tags = {
        Name = "web-server-luna-test"
    }
    
}


resource "aws_eip" "webserver_eip" {
    instance = aws_instance.webserver.id
}


resource "aws_security_group" "allow_http" {
    name = "web_access"


    dynamic "ingress" {
        iterator = port
        for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }


    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}


output "dbserver_private_ip" {
    value = aws_instance.dbserver.private_ip
}