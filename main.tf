

provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "aws-nginx-server-with-terraform"
    Environment = "test"
    Terraform = true
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
  }
}

resource "aws_subnet" "subnet-1a" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
  }
}

resource "aws_route_table_association" "association-1a" {
  subnet_id      = aws_subnet.subnet-1a.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "security-group" {
  name        = "secgroup-internet"
  description = "Allow ingress and egress connection to the internet"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "Allow HTTPS connection"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP connection"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH connection"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
  }
}

resource "aws_network_interface" "network-interface" {
  subnet_id       = aws_subnet.subnet-1a.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.security-group.id]

  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
  }
}

resource "aws_eip" "eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.network-interface.id
  associate_with_private_ip = "10.0.1.50"

  depends_on = [aws_internet_gateway.internet-gw]

  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
  }
}

data "aws_ami" "ubuntu-ami" {
  most_recent = true
  
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  } 
}

resource "aws_instance" "nginx-server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = var.instance_type

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.network-interface.id
  }

  user_data = file("init.sh")

  tags = {
    Name        = "aws-nginx-server-with-terraform",
    Environment = "test",
    Terraform = true
    
  }
}

