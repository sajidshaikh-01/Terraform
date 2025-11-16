# using existing vpc
data "aws_vpc" "default" {
  default = true
}

# security group allowing HTTP and SSH
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}


# EC2 instance with existinhg key pair and user data script
resource "aws_instance" "ec2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.existing_key_name
  security_groups = [aws_security_group.ec2_sg.name]

  user_data = file("userdata.sh")

  tags = {
    Name = "${var.project_name}-ec2"
  }

}
