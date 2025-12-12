#  Terraform Variables & Its Types — README
---

# 📌 What Are Variables in Terraform?

Variables allow you to **parameterize** your Terraform configuration.
They help you avoid hardcoding values and make your infrastructure reusable.

Example:

* Instance type
* AWS region
* Project name
* Multi-environment configs (dev, test, prod)

---

# 🧩 Types of Variables in Terraform

Terraform supports these key variable types:

1. **string**
2. **number**
3. **bool**
4. **list**
5. **map**
6. **set**
7. **tuple**
8. **object**

Below are definitions + examples.

---

# 1️⃣ String Variable

Used for text values.

### **Example: variable.tf**

```hcl
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
```

### **Use in main.tf**

```hcl
instance_type = var.instance_type
```

---

# 2️⃣ Number Variable

Used for numeric values.

### Example

```hcl
variable "instance_count" {
  type    = number
  default = 2
}
```

Use:

```hcl
count = var.instance_count
```

---

# 3️⃣ Boolean Variable

Used for true/false values.

### Example

```hcl
variable "enable_monitoring" {
  type    = bool
  default = true
}
```

Use:

```hcl
monitoring = var.enable_monitoring
```

---

# 4️⃣ List Variable

List = ordered collection of values.

### Example

```hcl
variable "availability_zones" {
  type = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}
```

Use:

```hcl
availability_zone = var.availability_zones[0]
```

---

# 5️⃣ Map Variable

Map = key-value data.

### Example

```hcl
variable "env_tags" {
  type = map(string)
  default = {
    env  = "dev"
    owner = "sajid"
  }
}
```

Use:

```hcl
tags = var.env_tags
```

---

# 6️⃣ Set Variable

Set = unique values only.

### Example

```hcl
variable "unique_ports" {
  type = set(number)
  default = [80, 443]
}
```

Use:

```hcl
for_each = var.unique_ports
```

---

# 7️⃣ Tuple Variable

Tuple = collection of **mixed types**.

### Example

```hcl
variable "server_info" {
  type = tuple([string, number, bool])
  default = ["webserver", 2, true]
}
```

Use:

```hcl
name     = var.server_info[0]
count    = var.server_info[1]
monitor  = var.server_info[2]
```

---

# 8️⃣ Object Variable

Object = struct-like, best for structured data.

### Example

```hcl
variable "app_config" {
  type = object({
    name     = string
    replicas = number
    enabled  = bool
  })

  default = {
    name     = "my-app"
    replicas = 3
    enabled  = true
  }
}
```

Use:

```hcl
name     = var.app_config.name
replicas = var.app_config.replicas
```

---

# 📂 How to Pass Variables

Terraform supports 3 ways:

## 1. Through **terraform.tfvars** file

```hcl
instance_type = "t3.micro"
```

## 2. Through CLI

```sh
terraform apply -var="instance_count=5"
```

## 3. Through environment variables

```sh
export TF_VAR_instance_type=t2.large
```

---

# 🧠 Real Use Case Example

### variables.tf

```hcl
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "tags" {
  type = map(string)
  default = {
    project = "devops"
    owner   = "sajid"
  }
}
```

### main.tf

```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  tags          = var.tags
}
```

---

# 📦 terraform.tfvars & custom .tfvars Files

Terraform allows you to store variable values in separate tfvars files.

---

# 1️⃣ **terraform.tfvars** (Default Variable File)

Terraform automatically loads `terraform.tfvars` if it exists.

### Example: terraform.tfvars

```hcl
instance_type = "t3.micro"
instance_count = 3
region = "ap-south-1"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
]

tags = {
  project = "devops"
  owner   = "sajid"
}
```

You simply run:

```sh
terraform apply
```

Terraform automatically picks these values.

---

# 2️⃣ **Custom .tfvars Files** (Environment Specific)

Useful when managing **dev, stage, prod** environments.

### Example Files:

* `dev.tfvars`
* `stage.tfvars`
* `prod.tfvars`

### Example: dev.tfvars

```hcl
instance_type = "t2.micro"
instance_count = 1
region = "ap-south-1"

tags = {
  env   = "dev"
  owner = "sajid"
}
```

### Example: prod.tfvars

```hcl
instance_type = "t3.medium"
instance_count = 4
region = "us-east-1"

tags = {
  env   = "prod"
  owner = "production-team"
}
```

### Apply a specific tfvars file:

```sh
terraform apply -var-file="dev.tfvars"
```

```sh
terraform apply -var-file="prod.tfvars"
```

---

# 3️⃣ Why tfvars Files Are Important

| Feature                   | terraform.tfvars | custom.tfvars |
| ------------------------- | ---------------- | ------------- |
| Auto-loaded               | ✅ Yes            | ❌ No          |
| Environment-specific      | ❌ No             | ✅ Yes         |
| Production use            | ⚠️ Sometimes     | ✅ Always      |
| Good for GitHub workflows | ❌ Medium         | ✅ Best        |

---

# 📝 Summary

| Type   | Use Case                     |
| ------ | ---------------------------- |
| string | Names, IDs, types            |
| number | Counts, sizes                |
| bool   | Enable/disable features      |
| list   | Multiple values (AZs, CIDRs) |
| map    | Tags, configs                |
| set    | Unique values                |
| tuple  | Mixed simple values          |
| object | Complex structured configs   |

