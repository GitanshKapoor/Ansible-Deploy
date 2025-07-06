resource "aws_instance" "web-00" {
  ami                    = var.ami_ids["aml"]
  instance_type          = "t3.micro"
  key_name               = "server-key"
  vpc_security_group_ids = [aws_security_group.remote-sg.id]
  availability_zone      = var.zone
  count                  = 3

  tags = {
    Name    = "Remote Machines"
    Project = "Ansible"
  }

}

resource "aws_instance" "web-01" {
  ami                    = var.ami_ids["ubuntu"]
  instance_type          = "t3.micro"
  key_name               = "server-key"
  vpc_security_group_ids = [aws_security_group.remote-sg.id]
  availability_zone      = var.zone

  tags = {
    Name    = "Remote Machines"
    Project = "Ansible"
  }

}

resource "aws_instance" "control-machine" {
  ami                    = var.ami_ids["ubuntu"]
  instance_type          = "t3.micro"
  key_name               = "controller-key"
  vpc_security_group_ids = [aws_security_group.main-sg.id]
  availability_zone      = var.zone

  tags = {
    Name    = "Control Machines"
    Project = "Ansible"
  }

  connection {
    type        = "ssh"
    user        = var.user1
    private_key = file("controller-key")
    host        = self.public_ip
  }

  # INSTALL ANSIBLE
  provisioner "remote-exec" {
    inline = [
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y"
    ]
  }
}

# ENSURE INSTANCE STATE
resource "aws_ec2_instance_state" "server-state" {
  instance_id = aws_instance.control-machine.id
  state       = "running"
}

# OUTPUT PUBLIC IP
output "Instance_Public_ip" {
  description = "Public IP address of the Control Machine"
  value       = aws_instance.control-machine.public_ip
}