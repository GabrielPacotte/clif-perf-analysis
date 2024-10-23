#!/bin/sh
echo Saving PWD...
tmp_pwd=$(echo $PWD)
cd $(dirname $0)

echo Deploying infrastructure with Terraform...

cd terraform
terraform init
terraform apply --auto-approve

echo "Waiting for server to boot up (10 secs may be enough)..."
sleep 10

echo Configuring server with Ansible...

cd ../ansible
ansible-playbook -i ./hosts.ini ./playbook.yml

echo Restoring PWD...

cd $(echo $tmp_pwd)

echo Done!