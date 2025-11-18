variable "allowed_ports" {
  default = [22, 80, 443]
}

resource "aws_security_group" "web" {
  name = "web-sg"
}

resource "aws_security_group_rule" "ingress" {
  for_each = toset(var.allowed_ports)

  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}
