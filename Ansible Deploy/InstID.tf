data "aws_ami" "amiID" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.*_HVM-*-x86_64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["309956199498"]
}

output "Instance_ID" {
  description = "ami-id-of-instances"
  value       = data.aws_ami.amiID.id
}

data "aws_ami" "amiID1" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "Instance_ID1" {
  description = "ami-id-of-instances"
  value       = data.aws_ami.amiID1.id
}