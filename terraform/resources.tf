resource "aws_key_pair" "demo_key" {
  key_name   = "demokey"
  public_key = file(var.public_key)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "apache" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance
  key_name      = aws_key_pair.demo_key.key_name

  vpc_security_group_ids = [
    "${aws_security_group.web.id}",
    "${aws_security_group.ssh.id}",
  ]
  connection {
    host = aws_instance.apache.public_ip
    private_key = file(var.private_key)
    user        = var.ansible_user
  }
  provisioner "remote-exec" {
    inline = ["sudo apt-get --allow-releaseinfo-change update ; sudo apt-get -qq update && sudo apt-get -qq install python -y && sudo apt-get -qq install ansible -y"]
  }
  provisioner "local-exec" {
    command = <<EOT
      sleep 30;
	  >java.ini;
	  echo "[java]" | tee -a java.ini;
	  echo "${aws_instance.apache.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a java.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i java.ini ../playbooks/install_java.yaml
    EOT
  }
  # This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
    command = <<EOT
      sleep 600;
	  >apache.ini;
	  echo "[apache]" | tee -a apache.ini;
	  echo "${aws_instance.apache.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a apache.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i apache.ini ../playbooks/install_apache.yaml
    EOT
  }
}

resource "aws_security_group" "web" {
  name        = "default-web-example"
  description = "Security group for web that allows web traffic from internet"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["81.90.124.242/32"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["81.90.124.242/32"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "default-ssh"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["81.90.124.242/32"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
