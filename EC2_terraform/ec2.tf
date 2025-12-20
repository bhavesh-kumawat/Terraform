# key pair
resource "aws_key_pair" "deployer_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# vpc & security group

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_default_vpc.default.id

  # inbound rules for ssh
  ingress {
    description      = "SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  # inbound rules for http
    ingress {
    description      = "HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

    # outbound rules
    egress {
        description      = "Allow all outbound traffic"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "automate-sg"
    }
}

# EC2 instance
resource "aws_instance" "my_ec2_instance" {

  #count = 2 # Launch 2 instances
  
  # Launch 2 instance with different name, instance_type
  # for_each = tomap({
  #   bk-junoon-automate-micro = "t2.micro"
  #   bk-junoon-automate-medium = "t2.medium"
  # })

  depends_on = [ aws_security_group.my_security_group, aws_key_pair.deployer_key ]

  ami           = var.ami_id #ubuntu
  # instance_type = each.value # use when use for_each
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prod" ? 15 : var.volume_size
    volume_type = "gp3"
  }

  tags = {
    # Name = each.key # use when use for_each
    Name = "tws-junoon-automate"
  }
}