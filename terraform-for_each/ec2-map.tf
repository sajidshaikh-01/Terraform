variable "servers" {
  default = {
    web = "t2.micro"
    app = "t3.micro"
    db  = "t3.medium"
  }
}

resource "aws_instance" "ec2" {
  for_each = var.servers

  ami           = "ami-04a37924ffe27da53"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
