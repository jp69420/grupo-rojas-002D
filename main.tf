terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "AUY1105-rojas-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = { Name = "AUY1105-rojas-vpc" }
}

resource "aws_subnet" "AUY1105-rojas-subnet" {
  vpc_id            = aws_vpc.AUY1105-rojas-vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "AUY1105-rojas-subnet" }
}

resource "aws_security_group" "AUY1105-rojas-sg" {
  name        = "AUY1105-rojas-sg"
  description = "Security group permite solo SSH entrante"
  vpc_id      = aws_vpc.AUY1105-rojas-vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "AUY1105-rojas-sg" }
}

resource "aws_instance" "AUY1105-rojas-ec2" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.AUY1105-rojas-subnet.id
  vpc_security_group_ids = [aws_security_group.AUY1105-rojas-sg.id]
  tags = { Name = "AUY1105-rojas-ec2" }
}
