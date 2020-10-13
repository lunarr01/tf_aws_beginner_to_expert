# Passes the websrvname variable from main.tf
variable "websrvname" {
    type = string
}


resource "aws_eip" "webserver_eip" {
    instance = var.websrvname
}