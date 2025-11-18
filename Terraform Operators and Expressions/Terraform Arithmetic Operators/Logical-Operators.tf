variable "env" { default = "dev" }
variable "enable_monitoring" { default = true }

output "should_monitor" {
  value = var.env == "prod" && var.enable_monitoring
}


| Operator | Meaning |   |    |
| -------- | ------- | - | -- |
| `&&`     | AND     |   |    |
| `        |         | ` | OR |
| `!`      | NOT     |   |    |
