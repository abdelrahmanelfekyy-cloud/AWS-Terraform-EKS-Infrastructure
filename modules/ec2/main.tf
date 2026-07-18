resource "aws_security_group" "bastion" {
  name        = "${var.environment}-bastion-sg"
  description = "Security group for Bastion Host / Jump Server"
  vpc_id      = var.vpc_id

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
    Name = "${var.environment}-bastion-sg"
  }
}

resource "aws_security_group_rule" "allow_ssh_from_bastion" {
  description              = "Allow SSH from Bastion Host"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = var.nodes_sg_id       
  source_security_group_id = aws_security_group.bastion.id 
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro" 
  subnet_id                   = var.public_subnet_ids[0] 
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = var.key_name
  associate_public_ip_address = true 

  
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              # تثبيت الـ AWS CLI
              sudo yum install -y aws-cli
              # تثبيت الـ kubectl للتحكم بالـ Kubernetes
              curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
              chmod +x ./kubectl
              sudo mv ./kubectl /usr/local/bin/kubectl
              EOF

  tags = {
    Name = "${var.environment}-bastion-host"
  }
}