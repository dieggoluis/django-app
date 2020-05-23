variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list
  default = ["10.0.1.0/24"]
}

variable "azs" {
  type    = list
  default = ["us-east-1a"]
}

variable "amis" {
  type = map
  default = {
    # Amazon Linux 2
    us-east-1 = "ami-0323c3dd2da7fb37d"
  }
}

variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "security_group_name" {
  default = "allow-ssh"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "launch_config_path" {
  default = "launch_config.sh"
}

variable "keys_name" {
  default = "ssh-keys"
}

variable "environment" {
  default = "DEV"
}
