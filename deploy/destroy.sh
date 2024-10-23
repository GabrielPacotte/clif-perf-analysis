#!/bin/sh
echo Saving PWD...
tmp_pwd=$(echo $PWD)
cd $(dirname $0)

echo Destroying infrastructure with Terraform...

cd terraform
terraform init
terraform destroy --auto-approve

echo Restoring PWD...

cd $(echo $tmp_pwd)

echo Done!