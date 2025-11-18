variable "base_port" { default = 8000 }

output "api_port" {
  value = var.base_port + 10
}



| Operator | Meaning        |
| -------- | -------------- |
| `+`      | Addition       |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `%`      | Modulus        |
