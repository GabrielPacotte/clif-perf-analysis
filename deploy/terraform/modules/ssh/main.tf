resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "ssh_key_pair" {
    key_name = "tp-perfs-ssh-key-pair"
    public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_sensitive_file" "ssh_private_key_file" {
    filename = "${path.module}/../../../ansible/ssh_private_key"
    content = tls_private_key.ssh_key.private_key_pem
}