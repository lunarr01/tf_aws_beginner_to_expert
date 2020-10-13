# Passes the sg_name variable from main.tf
variable "sg_name" {
    type = string
}


resource "aws_instance" "webserver" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    security_groups = [var.sg_name]
    tags = {
        Name = "web-server-luna-test"
    }  
}


output "webserver_id" {
    value = aws_instance.webserver.id
}