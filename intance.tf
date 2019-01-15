data "aws_ami" "centos-ami" {
  most_recent 	= true

  filter {
    name  		= "product-code"
    values 		= ["${var.centos_7_hvm_code}"]
  }

  owners 		= ["aws-marketplace"]
}

data "aws_ami" "aws-linux-ami" {
  most_recent 	= true

  filter {
    name  		= "name"
    values 		= ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }
  
  filter {
    name  		= "state"
    values 		= ["available"]
  }
  
  owners 		= ["amazon"]
}


resource "aws_instance" "centos" {
  # Uncomment for AWS Linux AMI
  #ami           			= "${data.aws_ami.aws-linux-ami.id}"
  ami           			= "${data.aws_ami.centos-ami.id}"
  instance_type 			= "t2.micro"
  key_name 					= "terraform-aws-keypair"
  subnet_id 				= "${aws_subnet.public-subnet-a.id}"
  vpc_security_group_ids	= [ "${aws_security_group.allow-ssh-and-egress.id}" ] 

  root_block_device {
    delete_on_termination = true
  }
  
  tags = {
    Name = "centos-bb"
  }
}

resource "aws_instance" "aws-linux" {
  # Uncomment for AWS Linux AMI
  ami           			= "${data.aws_ami.aws-linux-ami.id}"
  #ami           			= "${data.aws_ami.centos-ami.id}"
  instance_type 			= "t2.micro"
  key_name 					= "terraform-aws-keypair"
  subnet_id 				= "${aws_subnet.public-subnet-a.id}"
  vpc_security_group_ids	= [ "${aws_security_group.allow-ssh-and-egress.id}" ] 

  root_block_device {
    delete_on_termination = true
  }
    
  tags = {
    Name = "aws-lnx-bb"
  }
}

resource "aws_key_pair" "terraform-aws-keypair" {
  key_name 		= "terraform-aws-keypair"
  public_key 	= "${file("${var.ssh_public_key_path}")}"
}

resource "aws_security_group" "allow-ssh-and-egress" {
  name = "main"

  description = "Allows SSH traffic into instances as well as all eggress."
  vpc_id = "${aws_vpc.default.id}"

  ingress {
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

  tags {
    Name = "allow_ssh-all"
  }
}