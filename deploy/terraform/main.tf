provider "aws" {
    region = "eu-west-3"
}

module "networking" {
    source = "./modules/networking"
}

module "ssh" {
    source = "./modules/ssh"
}

module "server" {
    source = "./modules/server"

    vpc_id = module.networking.vpc_id
    subnet_id = module.networking.public_subnet_id
    ssh_key_name = module.ssh.ssh_key_name
}

module "ansible_files" {
    source = "./modules/ansible"

    server_public_ip = module.server.public_ip
}