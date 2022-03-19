variable "profile" {
  default = "be-dev"
}

variable "region" {
  default = "us-east-1"
}

variable "instance" {
  default = "t2.nano"
}

variable "public_key" {
  default = "~/.ssh/demo/demoKeyPair.pub"
}

variable "private_key" {
  default = "~/.ssh/demo/demoKeyPair"
}

variable "ansible_user" {
  default = "ubuntu"
}


