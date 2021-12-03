provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    self = false
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "bafb9cf4d9f5488223c0dcbbce6a1b0789b7cbec"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-01 14:39:09"
    git_last_modified_by = "shane.sorbello@gmail.com"
    git_modifiers        = "shane.sorbello"
    git_org              = "ssorb"
    git_repo             = "terragoat"
    yor_trace            = "1a401889-a498-4db5-bdaa-9c493a218059"
  }
  vpc_id = "vpc-1539e673"
}


resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "bafb9cf4d9f5488223c0dcbbce6a1b0789b7cbec"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-01 14:39:09"
    git_last_modified_by = "shane.sorbello@gmail.com"
    git_modifiers        = "shane.sorbello"
    git_org              = "ssorb"
    git_repo             = "terragoat"
    yor_trace            = "1838fb7f-f497-436f-a4db-3bb5e58bc81a"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
