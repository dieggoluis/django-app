# provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# network
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs            = var.azs
  public_subnets = var.public_subnets

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# security group
resource "aws_security_group" "web_server" {
  vpc_id = module.vpc.vpc_id
  name   = var.security_group_name

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform   = "true"
    Name        = "security-group-web-server"
    Environment = var.environment
  }
}

# ssh keys
resource "aws_key_pair" "keys" {
  key_name   = var.keys_name
  public_key = file(var.public_key_path)
}

# ec2 instance
resource "aws_instance" "django_app" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = var.instance_type
  key_name      = aws_key_pair.keys.id

  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.web_server.id]

  provisioner "remote-exec" {
    script = var.launch_config_path

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      agent       = false
      timeout     = "2m"
      host        = self.public_ip
    }
  }

  tags = {
    Terraform   = "true"
    Name        = "django-app-instance"
    Environment = var.environment
  }
}
