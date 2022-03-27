# Create a key pair
resource "tls_private_key" "lab" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "lab" {
  key_name   = "kubernetes-the-hard-way"
  public_key = tls_private_key.lab.public_key_openssh
}

resource "local_file" "lab_private_key" {
    content     = tls_private_key.lab.private_key_pem
    filename = pathexpand("~/.ssh/k8s-the-hard-way.pem")
}


# Get a compatible Ubuntu EC2 AMI dynamically
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


# Instances
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.lab.key_name
  subnet_id                   = var.public_subnet[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [
                                  aws_security_group.bastion.id,
                                ]

  tags = merge(
                local.common_tags,
                {
                  Name = "Kubernetes Bastion",
                },
              )
}

resource "aws_instance" "master" {
  count = 3

  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.lab.key_name
  subnet_id       = element(var.private_subnet, count.index)
  vpc_security_group_ids = [
                             aws_security_group.k8s_master.id,
                           ]

  tags = merge(
                local.common_tags,
                {
                  Name = "Kubernetes Master",
                },
              )
}

resource "aws_instance" "worker" {
  count = 3

  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.lab.key_name
  subnet_id       = element(var.private_subnet, count.index)
  vpc_security_group_ids = [
                             aws_security_group.k8s_worker.id,
                           ]

  tags = merge(
                local.common_tags,
                {
                  Name = "Kubernetes Worker",
                },
              )
}
