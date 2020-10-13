provider "aws" {
    profile = "ihm"
    region = "us-east-1"
}


resource "aws_db_instance" "myRDS" {
    name = "myDB"
    identifier = "my-first-rds"
    instance_class = "db.t2.micro"
    engine = "mariadb"
    engine_version = "10.2.21"
    # NEVER keep passwords in terraform
    username = "bob"
    password = "password123"
    port = 3306
    allocated_storage = 20
    #below is to prevent errors when destroying the DB via terraform 
    skip_final_snapshot = true
}