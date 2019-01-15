output "CentOS AMI" {
  value = "${data.aws_ami.centos-ami.id}"
}

output "AWS Linux AMI" {
  value = "${data.aws_ami.aws-linux-ami.id}"
}