# terraform-aws-sample
This project demonstrate how deploy a centos AMI from marketplace to a new VPC on AWS. Terraform will create:

- VPC
- Subnets
- Gateway
- Routing tables
- Security Groups
- KeyPair (importing existing ssh public key)
- EC2 CentOS instance from Marketplace (dynamicly choosing the most recent AMI image)

## Requirements
- Terraform and AWS-CLI must be previously installed.
- Linux or MacOS machine must be used to run the project
- AWS IAM credentials (aws_access_key_id/aws_secret_access_key) with correct permissions must be created and configured before execute the project.
- Linux SSH keyPair (private/public keys)

## Terraform AWS Configuration
Before execute the project a new AWS profile must created using the following commands:

`
aws configure --profile-name terraform
`

Will be asked:

- AWS Access Key ID []: access key used by terraform 
- AWS Secret Access Key []: secret key used by terraform
- Default region name []: region where terraform will create resource
- Default output format [json]: 

## How to execute
Clone the git repository:
`
git clone https://github.com/xjulio/terraform-aws-sample.git
`

Enter the repository directory:

`
cd terraform-aws-sample
`

## Terraform variables
Some variables must be configured before execute the projet. Edit **terraform.tfvars**

<pre>
# Default Region - Oregon US
aws_region = "us-west-2"

# Set credentials here or leave in black to use ~/.aws/credentials file generate by aws-cli
aws_access_key = ""
aws_secret_key = ""

# Name of AWS KeyPair
aws_key_name = "terraform-aws"

# Path for SSH public key
ssh_private_key_path = "~/.ssh/id_rsa" 
ssh_public_key_path = "~/.ssh/id_rsa.pub"

# Centos 7 HVM Product code to be used in filter
centos_7_hvm_code = "aw0evgkw8e5c1q413zgy5pjce"
</pre>

Change the value of the variables:
- aws_region: default region
- aws_key_name: AWS key that will be created by terraform by importing your SSH Public Key
- aws_access_key and aws_secret_key: if leaved in blank, terraform will use ~/.aws/credentials file
- ssh_private_key_path: ssh private key (this key will note be used for nothing in thsi project)
- ssh_public_key_path: ssh public key used by terraform to import in the new AWS KeyPair that will be created to access the VM instance

## Terraform main.tf
In the main.tf file, we must configure the credentials and the profile name that will be used by terraform:

<pre>
provider "aws" {
  # Update values on terraform.tfvars file or use ~/.aws/credentials file
  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
  
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"  
  region                  = "${var.aws_region}"
}
</pre>

## Creating resources
Execute the command to verify if everything is OK.

`
terraform plan
`

If there's no error during the plan phase, execute the command:

`
terraform apply
`

## Accepting the Marketplace EULA
Because we are not using an AWS AMI image (The CentOS is from Marketplace), it's required to loggin into AWS console and click "I Agree" link provied during the `terraform apply`.
