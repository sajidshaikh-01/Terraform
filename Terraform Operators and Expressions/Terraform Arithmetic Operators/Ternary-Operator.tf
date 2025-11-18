resource "aws_instance" "web" {
  instance_type = var.env == "prod" ? "t3.large" : "t2.micro"
}
