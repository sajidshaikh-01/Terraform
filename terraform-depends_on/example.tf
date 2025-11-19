resource "aws_security_group" "web_sg" {
  name = "web-sg"
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t2.micro"

  depends_on = [
    aws_security_group.web_sg
  ]
}
