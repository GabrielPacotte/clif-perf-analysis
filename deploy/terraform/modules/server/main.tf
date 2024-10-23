resource "aws_security_group" "main_security_group" {
  name        = "allow-udp-5432"
  description = "Autorise le trafic UDP entrant et sortant sur le port 5432"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 5432
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tp-perfs-udp-5432-sg"
  }
}

resource "aws_instance" "main_instance" {
  ami           = "ami-00d81861317c2cc1f"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main_security_group.id]

  associate_public_ip_address = true

  key_name = var.ssh_key_name

  tags = {
    Name = "udp-5432-instance"
  }
}