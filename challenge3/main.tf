provider "aws" {
  region  = "us-east-1"
  profile = "ihm"
}


module "dbserver" {
  source = "./dbserv"
}


# Displays the private ip of the DB server fron ./dbserv/dbserv.tf resource
output "module_output_dbserver" {
  value = module.dbserver.dbserver_privateip
}


# Passes the webserver_id output from ./webserv/webserv.tf as a variable to the ./eip/eip.tf resource
module "webserver" {
  source  = "./webserv"
  sg_name = [module.sg.security_group_name]
}


# Takes the security_group_name output from .sg/sg.tf & passes it as a variable to the module "webserver" ref on main.tf
output "module_output_security_group_name" {
  value = module.sg.security_group_name
}


module "sg" {
  source = "./sg"
}


# Takes the webserver_id output from ./webserver/webser.tv & passes it as a variable to the module "elasticip" ref on main.tf
output "module_output_webserver_id" {
  value = module.webserver.webserver_id
}


# Passes the webserver_id output from ./webserv/webserv.tf as a variable to the ./eip/eip.tf resource
module "elasticip" {
  source     = "./eip"
  websrvname = [module.webserv.webserver_id]
}