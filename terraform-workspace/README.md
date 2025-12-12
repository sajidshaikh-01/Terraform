# 🗂️ Terraform Workspaces — Complete README
---
# 🌟 What Are Terraform Workspaces?

A **workspace** in Terraform allows you to maintain **multiple state files** for the same configuration.

In simple words:

> **Workspaces = multiple environments (dev, stage, prod) using the same Terraform code but separate state files.**

Terraform automatically creates a default workspace called **default**.

---

# ❓ Why Do We Need Workspaces?

Workspaces are useful when:

* You want to reuse the same Terraform code for **multiple environments**.
* You want **separate state files** for dev, stage, prod.
* You want to test changes safely before applying to production.

---

# ⚠️ Important Note

Workspaces are best used for **simple environments**, NOT for:

* completely different infrastructure
* large production deployments
* multiple cloud setups

For real production systems → **Folder-based environments** or **Terraform Cloud workspaces** are preferred.

---

# 🧪 1. Workspace Commands

### **List all workspaces**

```sh
terraform workspace list
```

### **Create a new workspace**

```sh
terraform workspace new dev
```

### **Switch workspace**

```sh
terraform workspace select dev
```

### **Show current workspace**

```sh
terraform workspace show
```

### **Delete a workspace**

```sh
terraform workspace delete dev
```

⚠️ You cannot delete a workspace if it contains resources.

---

# 🗃️ 2. Workspace State File Example

Workspaces create different state file paths automatically.

If backend is S3:

### **dev workspace state file**

```
s3://mybucket/terraform.tfstate-env:/dev
```

### **prod workspace state file**

```
s3://mybucket/terraform.tfstate-env:/prod
```

Each workspace = its own isolated state file.

---

# 📘 3. Using Workspace in Terraform Code

Terraform provides this built-in variable:

```hcl
terraform.workspace
```

You can use it to dynamically set values.

---

# 🧩 4. Example: EC2 AMI Based on Workspace

```hcl
locals {
  ami = terraform.workspace == "prod" ? "ami-prod-123" : "ami-dev-456"
}

resource "aws_instance" "web" {
  ami           = local.ami
  instance_type = "t2.micro"
}
```

---

# 🧩 5. Example: Tags Based on Workspace

```hcl
tags = {
  Environment = terraform.workspace
  Owner       = "sajid"
}
```

Output:

* For dev → `Environment = dev`
* For prod → `Environment = prod`

---

# 🧩 6. Example: Using Workspace in Backend Key

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "env/${terraform.workspace}/terraform.tfstate"
    region = "ap-south-1"
  }
}
```

Workspaces automatically create:

* `env/dev/terraform.tfstate`
* `env/stage/terraform.tfstate`
* `env/prod/terraform.tfstate`

---

# 🧪 7. Full Example: Multi-Environment Deployment

## Step 1️⃣ — Initialize Terraform

```sh
terraform init
```

## Step 2️⃣ — Create workspaces

```sh
terraform workspace new dev
terraform workspace new prod
```

## Step 3️⃣ — Deploy in dev

```sh
terraform workspace select dev
terraform apply
```

Creates infrastructure with **dev-specific state**.

## Step 4️⃣ — Deploy in prod

```sh
terraform workspace select prod
terraform apply
```

Creates **independent prod infrastructure** using the same code.

---

# 📦 8. When Should You NOT Use Workspaces?

Workspaces are **NOT recommended** when:

| Scenario                     | Why Not?                                             |
| ---------------------------- | ---------------------------------------------------- |
| Large teams                  | Hard to control workspace switching                  |
| Multiple cloud accounts      | Workspaces cannot switch providers easily            |
| Different infra for dev/prod | Code becomes too complex                             |
| CI/CD pipelines              | Workspaces cause conflicts if multiple pipelines run |

For real production systems → use **separate folders** like:

```
/terraform/
  dev/
  stage/
  prod/
```




🔥 Backend configuration for multi-environments

