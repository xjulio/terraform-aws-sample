provider "aws" {
  # Update values on terraform.tfvars file or use ~/.aws/credentials file
  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
  
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"  
  region                  = "${var.aws_region}"
}