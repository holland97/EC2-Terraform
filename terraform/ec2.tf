resource "aws_instance" "ec2-instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.project-subnet.id
  vpc_security_group_ids = [aws_security_group.project-sg.id]
  key_name               = aws_key_pair.TF_key.key_name
  tags = {
    Name = var.tag
  }
}

# Creates public key
resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
  tags = {
    Name = var.tag
  }
}

# Creates private key
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Make a local file on the system for the private key
resource "local_file" "private-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key"
}


resource "aws_ec2_instance_connect_endpoint" "endpoint" {
  subnet_id = aws_subnet.project-subnet.id
  tags = {
    Name = var.tag
  }
}
