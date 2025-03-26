resource "aws_vpc" "main_subnet" {
  
  cidr_block = var.vpc_cidr
  enable_dns_support =  true 
  enable_dns_hostnames = true 
  
}
resource "aws_subnet" "aws_public_subnet1" {
  vpc_id = var.vpc_cidr
  cidr_block = var.public_subnet_cidr
  availability_zone = var.aws_region
  
}
resource "aws_subnet" "aws_public_subnet2" {
  vpc_id = var.vpc_cidr
  cidr_block = var.aws_public_subnet2
  availability_zone = var.aws_region

}
resource "aws_internet_gateway" "web_IGW" {
  vpc_id = aws_vpc.main_subnet.id
  
}
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main_subnet.id
}

resource "aws_route" "intenet_access" {
  route_table_id = aws_route_table.public_RT.id

}

resource "aws_route_table_association" "public_assoc1" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id = aws_subnet.aws_public_subnet1.id
  
}

resource "aws_route_table_association" "public_assoc2" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id = aws_subnet.aws_public_subnet2.id
  
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main_subnet.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access (Change this to your IP)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_instance" "web" {
  ami           = "ami-0fc5d935ebf8bc3bc" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.web_sg.name]
  key_name      = "your-key-pair"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg \
                lsb-release

              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

              apt update -y
              apt install -y docker-ce docker-ce-cli containerd.io docker-compose
EOF
  tags = {
    Name = "WordPressServer"
  }
}



