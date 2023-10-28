resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "project-subnet" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true # assigns IP adress to stuff created in this subnet

  tags = {
    Name = var.tag
  }
}

resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project-vpc.id
  tags = {
    Name = var.tag
  }
}

resource "aws_route_table" "project-route-table" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }

  tags = {
    Name = var.tag
  }
}

# Creates assoication between route table and subnet 
resource "aws_route_table_association" "project-rt-association" {
  subnet_id      = aws_subnet.project-subnet.id
  route_table_id = aws_route_table.project-route-table.id
}

resource "aws_security_group" "project-sg" {
  description = "Allow SSH"
  name        = "project-sg"
  vpc_id      = aws_vpc.project-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "var.tag"
  }

}
