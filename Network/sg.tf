# Bastion Security Group
resource "aws_security_group" "bastion_sg" {
  vpc_id      = aws_vpc.prod_vpc.id
  description = "Allow SSH from the world"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project-Bastion-SG"
  }
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.prod_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project-ALB-SG"
  }
}

data "aws_caller_identity" "current" {}

data "aws_security_group" "cloud9_sg" {
  filter {
    name   = "group-name"
    values = ["sg-076247a61a1ffb4c4"]
  }
}

# Web Server Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.prod_vpc.id
  description = "Allow HTTP from ALB and SSH from Bastion and Ansible Host"

  # Allow HTTP traffic from ALB SG
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  # Allow SSH from Bastion SG
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

# Allow SSH traffic from Cloud9's public IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [data.aws_security_group.cloud9_sg.id]
    
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project-Web-SG"
  }
}


# Security Group for Private Instances (Restricting access only from Bastion Host)
resource "aws_security_group" "private_instance_sg" {
  vpc_id      = aws_vpc.prod_vpc.id
  description = "Allow SSH only from Bastion Host"

  ingress {
    description = "Allow SSH from Bastion Host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project-Private-Instance-SG"
  }
}