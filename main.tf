terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {

  region                   = var.aws_region
  profile                  = var.aws_profile
  shared_credentials_files = ["/path/to/credentials"]
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true 
  enable_dns_hostnames = true 
  tags = {
    name = "main_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
 cidr_block =var.public_subnet_cidr
 availability_zone =" east-1a"
 map_public_ip_on_launch = true 
 tags = {
  name = "public_subnet"
  
 }
}

