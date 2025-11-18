resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "my-subnet" {
  count             = 3
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = cidrsubnet(aws_vpc.my-vpc.cidr_block, 8, count.index)
  
}


#creating 4 ec2 instances
resource "aws_instance" "my-ec2" {
  count         = 4
  ami           = "ami-0ecb62995f68bb549" # Example AMI ID for us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my-subnet[count.index % length(aws_subnet.my-subnet)].id

  tags = {
    Name = "MyEC2Instance-${count.index + 1}"
  }
}
