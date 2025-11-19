resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.security_groups
  user_data              = var.user_data

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

