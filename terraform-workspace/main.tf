# -------------------------------
# EC2 Instance Changes Per Workspace
# -------------------------------
resource "aws_instance" "workspace_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type[terraform.workspace]

  tags = {
    Name        = "ec2-${terraform.workspace}"
    Environment = terraform.workspace
  }
}
