provider "aws" {
    profile = "ihm"
    region = "us-east-1"
}


module "db" {
    source = "./db"
    server_names = ["mariadb","mysql","mysql"]
    
}


output "private_ips" {
    value = module.db.PrivateIP
}