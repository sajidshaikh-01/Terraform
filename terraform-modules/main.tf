
provider "aws" {
  region = "us-east-1"
}

module "simple_ec2" {
  source        = "./modules/ec2"
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  name          = "my-first-module-ec2"
}
