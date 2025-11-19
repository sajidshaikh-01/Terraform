module "demo" {
  source = "../.."

  name            = "demo-ec2"
  ami_id          = "ami-04a37924ffe27da53"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-12345"
  key_name        = "mykey"
  security_groups = ["sg-123"]

  tags = {
    Owner = "Sajid"
  }
}

