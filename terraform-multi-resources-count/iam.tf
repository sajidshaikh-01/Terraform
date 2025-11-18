variable "users" {
  default = ["sajid", "rahul", "vishal"]
}

resource "aws_iam_user" "dev_users" {
  count = length(var.users)
  name  = var.users[count.index]
}

