variable "ingressrules" {
    type = list(number)
    default = [80,443]
}


variable "egressrules" {
    type = list(number)
    default = [80,443]
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


output "security_group_name" {
    value = aws_security_group.allow_http.name
}