variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}
variable "centos_7_hvm_code" {}

variable "ssh_private_key_path" {}
variable "ssh_public_key_path" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr-a" {
    description = "CIDR for the Public Subnet"
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr-b" {
    description = "CIDR for the Public Subnet"
    default = "10.0.2.0/24"
}

variable "public_subnet_cidr-c" {
    description = "CIDR for the Public Subnet"
    default = "10.0.3.0/24"
}