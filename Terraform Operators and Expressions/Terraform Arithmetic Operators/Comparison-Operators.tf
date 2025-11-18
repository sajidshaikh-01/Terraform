variable "env" { default = "prod" }

output "instance_type" {
  value = var.env == "prod" ? "t3.large" : "t2.micro"
}


| Operator | Meaning          |
| -------- | ---------------- |
| `==`     | Equal            |
| `!=`     | Not equal        |
| `>`      | Greater          |
| `<`      | Lesser           |
| `>=`     | Greater or equal |
| `<=`     | Lesser or equal  |
