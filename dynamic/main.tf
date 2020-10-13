provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


variable "inputec2name" {
    type = string
    description = "give 3c2 instance a name"
}


variable "ingressrules" {
    type = list(number)
    default = [80,443]
}


variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}


resource "aws_instance" "ec2-test" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    tags = {
        Name = var.inputec2name
    }
}


resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"


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

    tags = {
        Name = "allow_tls"
    }
}

output "ec2name" {
    value = aws_instance.ec2-test.id
}