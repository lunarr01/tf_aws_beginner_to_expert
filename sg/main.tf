provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


variable "inputec2name" {
    type = string
    description = "give 3c2 instance a name"
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


    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_tls"
    }
}

output "ec2name" {
    value = aws_instance.ec2-test.id
}