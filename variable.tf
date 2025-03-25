variable "aws_access_key" {
  description = "aws_access_key"
  type        = string

}

variable "aws_secret_key" {
  description = "aws_secret_key"
  type = string

}
variable "aws_region" {
  description = "default aws region"
  default     = "us-east-1"
  type        = string

}
variable "aws_profile" {
  description = "default aws profile"
  default     = "default"
  type        = string

}

variable "aws_shared_credentials_file" {
  description = "share credentials file"
  default     = "~/.aws/credentials"
  type        = string


}
variable "vpc_cidr" {
  description = "vpc_cidr"
  type        = string
  default     = "10.92.0.0/16"

}


variable "public_subnet_cidr" {
  description = "public_subnet_cidr"
  type        = string
  default     = "10.92.1.0/24"

}
variable "private_subnet_cidr" {
 description = "private_subnet_cidr"
  type        = string
  default     = "10.92.2.0/24"

 
}



