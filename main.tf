resource "aws_vpc" "main_subnet" {
  
  cidr_block = var.vpc_cidr
  enable_dns_support =  true 
  enable_dns_hostnames = true 
  
}
resource "aws_subnet" "aws_public_subnet" {
  vpc_id = var.vpc_cidr
  cidr_block = var.public_subnet_cidr
  availability_zone = var.aws_region
  
}
resource "aws_subnet" "aws_private_subnet" {
  vpc_id = var.vpc_cidr
  cidr_block = var.private_subnet_cidr
  availability_zone = var.aws_region

}
