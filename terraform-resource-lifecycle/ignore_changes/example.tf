resource "aws_instance" "web" {
  instance_type = "t3.micro"
  user_data     = file("userdata.sh")

  lifecycle {
    ignore_changes = [
      user_data,
      tags["LastUpdated"]
    ]
  }
}
