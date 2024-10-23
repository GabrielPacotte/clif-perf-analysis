resource "local_file" "ansible_host_file" {
    filename = "${path.module}/../../../ansible/hosts.ini"
    content  = <<EOF
[server]
${var.server_public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=./ssh_private_key
EOF
}