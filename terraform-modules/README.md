#  Terraform Modules — Complete README
---
#  What Are Terraform Modules?

A **module** in Terraform is a reusable container of multiple resources.

Think of modules as:

* Reusable infrastructure components
* Similar to functions in programming
* Easy way to manage large Terraform code

Terraform automatically treats every folder with `.tf` files as a module.
The root folder = **root module**.

---

#  Why Use Modules?

Modules help you:

* Avoid repeating code
* Standardize infrastructure
* Manage complex infra with clean structure
* Reuse VPC, EC2, RDS, Load Balancer, S3 logic
* Improve maintainability

---

# 📂 Folder Structure Example (Modules)

```
project/
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│
└── modules/
     └── ec2/
         │── main.tf
         │── variables.tf
         │── outputs.tf
```

---

#  Example: EC2 Module

## 📁 modules/ec2/main.tf

```hcl
resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.name
  }
}
```

## 📁 modules/ec2/variables.tf

```hcl
variable "ami" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "name" {
  type = string
}
```

## 📁 modules/ec2/outputs.tf

```hcl
output "public_ip" {
  value = aws_instance.this.public_ip
}

output "id" {
  value = aws_instance.this.id
}
```

---

# 🏗 Using the EC2 Module (Root Module)

## 📁 main.tf

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "myserver" {
  source        = "./modules/ec2"
  ami           = var.ami
  name          = "dev-server"
  instance_type = "t2.micro"
}
```

## 📁 variables.tf

```hcl
variable "ami" {
  type = string
}
```

## 📁 terraform.tfvars

```hcl
ami = "ami-0e6329e222e662a52"
```

---

#  Access Module Outputs

## 📁 outputs.tf

```hcl
output "server_public_ip" {
  value = module.myserver.public_ip
}
```

---

#  Using Modules Multiple Times

```hcl
module "server1" {
  source = "./modules/ec2"
  ami    = var.ami
  name   = "app-server-1"
}

module "server2" {
  source = "./modules/ec2"
  ami    = var.ami
  name   = "app-server-2"
}
```

This creates **two EC2 instances**, without rewriting code.

---

#  Example: Official Terraform Registry Module

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
}
```

Terraform Registry provides 1000+ ready modules.

---

#  Real DevOps Use Cases for Modules

| Module     | Use Case                             |
| ---------- | ------------------------------------ |
| VPC module | Standard VPC across all environments |
| EC2 module | Create reusable compute instances    |
| RDS module | Database creation with variables     |
| ALB module | Reusable load balancer config        |
| S3 module  | Centralized bucket creation          |

---
