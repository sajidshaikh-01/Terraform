variable "instance_names" {
  default = ["web", "app", "db"]
}

resource "aws_instance" "ec2" {
  for_each = toset(var.instance_names)

  ami           = "ami-04a37924ffe27da53"
  instance_type = "t2.micro"

  tags = {
    Name = each.key
  }
}

