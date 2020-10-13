resource "aws_instance" "dbserver" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    tags = {
        Name = "DB Server"
    }
}


output "dbserver_privateip" {
    value = aws_instance.dbserver.private_ip
}