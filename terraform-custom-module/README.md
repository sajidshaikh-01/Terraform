# terraform-aws-ec2

A reusable Terraform module to deploy EC2 instances on AWS.

## Usage

```hcl
module "ec2" {
  source = "github.com/<YOUR_GITHUB_USERNAME>/terraform-aws-ec2"

  name             = "my-server"
  ami_id           = "ami-04a37924ffe27da53"
  instance_type    = "t2.micro"
  subnet_id        = "subnet-12345"
  key_name         = "mykey"
  security_groups  = ["sg-123"]
  user_data        = file("userdata.sh")

  tags = {
    Environment = "dev"
  }
}

| Name            | Type   | Description           |
| --------------- | ------ | --------------------- |
| name            | string | EC2 name              |
| instance_type   | string | EC2 size              |
| ami_id          | string | AMI                   |
| subnet_id       | string | Subnet                |
| key_name        | string | Existing AWS key pair |
| security_groups | list   | SGs                   |
| tags            | map    | tags                  |
| user_data       | string | script                |





---

# 🧩 **examples/basic/main.tf**  
Registry requires at least one example.

```hcl
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
