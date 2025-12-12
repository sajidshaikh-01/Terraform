# 🔀 Terraform Conditions — Complete README
---

# 🌟 What Are Conditions in Terraform?

Terraform uses conditional expressions to decide values based on **true/false logic**.

They work like:

```hcl
condition ? value_if_true : value_if_false
```

Example:

```hcl
var.environment == "prod" ? 3 : 1
```

Meaning:

* If environment = prod → 3 instances
* Else → 1 instance

---

# 1️⃣ Basic Conditional Expression

```hcl
variable "environment" {}

locals {
  instance_count = var.environment == "prod" ? 3 : 1
}
```

Use:

```hcl
count = local.instance_count
```

---

# 2️⃣ Condition Inside Resource

```hcl
resource "aws_instance" "web" {
  count         = var.enable_server ? 1 : 0
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

Meaning:

* If `enable_server = true` → create server
* Else → do not create

---

# 3️⃣ Conditions with Strings

```hcl
locals {
  instance_type = var.environment == "prod" ? "t3.medium" : "t2.micro"
}
```

Use:

```hcl
instance_type = local.instance_type
```

---

# 4️⃣ Conditions with Maps (Advanced)

```hcl
variable "environment" {}

locals {
  types = {
    dev  = "t2.micro"
    prod = "t3.large"
  }

  selected_type = local.types[var.environment]
}
```

Use:

```hcl
instance_type = local.selected_type
```

---

# 5️⃣ Using Conditions with count

`count` is best for enabling/disabling resources.

```hcl
resource "aws_s3_bucket" "logs" {
  count  = var.enable_logs ? 1 : 0
  bucket = "my-log-bucket"
}
```

---

# 6️⃣ Using Conditions with for_each

```hcl
resource "aws_iam_user" "users" {
  for_each = var.create_users ? toset(["raj", "sam"]) : []

  name = each.value
}
```

If `create_users = false` → no users are created.

---

# 7️⃣ Conditional Tags Example

```hcl
tags = var.environment == "prod" ? {
  env    = "prod"
  secure = "true"
} : {
  env = "dev"
}
```

---

# 8️⃣ Dynamic Blocks + Conditions (Advanced)

Used for optional configurations.

```hcl
resource "aws_security_group" "example" {
  name = "example-sg"

  dynamic "ingress" {
    for_each = var.enable_http ? [1] : []

    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

If `enable_http = false` → No ingress rule is created.

---

# 9️⃣ Real DevOps Use Case

### Select instance type based on environment

```hcl
locals {
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
}
```

### Enable CloudWatch alarms only for prod

```hcl
resource "aws_cloudwatch_metric_alarm" "cpu" {
  count = var.environment == "prod" ? 1 : 0
  alarm_name = "high-cpu"
  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
}
```



* Interview questions for Terraform conditions
