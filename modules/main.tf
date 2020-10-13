provider "aws" {
    region = "us-east-1"
    profile = "ihm"
}


module "ec2module" {
    source = "./ec2"
    ec2name = "tf-module-luna-test"
    
}


output "module_output" {
    value = module.ec2module.instance_id
}