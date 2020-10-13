variable "server_names" {
    type = list(string)
}


resource "aws_instance" "db" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
    count = length(var.server_names)
    tags = {
        Name = var.server_names[count.index]
    }
}


output "PrivateIP" {
    # having an astrisc * will include all instances
    value = [aws_instance.db.*.private_ip]
}