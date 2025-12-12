# 📘 Terraform State, Remote State & State Locking 

* What is **Terraform State**
* Why it is required
* What is **Remote State**
* Why we need **State Locking**
* How to configure S3 + DynamoDB backend for production
* Full examples with commands

---

# 🌍 1. What is Terraform State?

Terraform uses a file called **terraform.tfstate** to store the current state of your infrastructure.

It contains real-world resource information, including:

* Resource IDs (EC2 ID, S3 ARN, VPC ID)
* Dependencies
* Metadata
* Outputs

### 📌 Why is state required?

Terraform needs the state file to:

* Track what resources exist
* Know what changes to apply
* Map the `.tf` code to actual cloud resources

Without state, Terraform **cannot** manage infrastructure.

### ⚠️ Default Behavior

By default, Terraform stores `terraform.tfstate` **locally**.

This is NOT recommended for teams or production.

---

# 📦 2. Problems with Local State

Local state becomes risky because:

* ❌ It can get deleted accidentally
* ❌ Team members cannot share it
* ❌ Terraform cannot collaborate
* ❌ Sensitive values may leak
* ❌ No locking → race conditions

Hence, production setups always use **Remote State**.

---

# 🌐 3. What is Remote State?

Remote state stores your Terraform state file in a **central, secure backend** like:

* AWS S3
* Azure Blob Storage
* Google Cloud Storage
* Terraform Cloud

### ⭐ Benefits of Remote State

| Feature         | Benefit                      |
| --------------- | ---------------------------- |
| Central storage | Team collaboration           |
| Secure          | Prevents data loss           |
| Encrypted       | Protects sensitive values    |
| State locking   | Prevents conflicting updates |
| Versioning      | Rollback support             |

---

# 🔒 4. What is State Locking?

State locking ensures that **only one person or process can modify the state at a time**.

Example:
Two engineers run `terraform apply` at the same time:

* Without locking → Terraform corrupts state ❌
* With locking → One waits until the lock is released ✔

In AWS:

* **DynamoDB** provides state locking when using S3 backend.

---

# ⚙️ 5. Configure Remote State (S3 + DynamoDB) — Production Setup

## Step 1️⃣ — Create S3 Bucket for State

```sh
aws s3api create-bucket --bucket terraform-state-bucket-123 \
  --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
```

Enable versioning:

```sh
aws s3api put-bucket-versioning --bucket terraform-state-bucket-123 \
  --versioning-configuration Status=Enabled
```

---

## Step 2️⃣ — Create DynamoDB Table for Locking

```sh
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

---

## Step 3️⃣ — Configure Backend in Terraform

Create a file: **backend.tf**

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-123"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

## Step 4️⃣ — Initialize Backend

```sh
terraform init
```

Terraform will:

* Move local state → S3
* Enable locking with DynamoDB
* Configure encryption & versioning

---

# 📤 6. View Remote State

Terraform automatically downloads the latest state to a local cache.

Show state list:

```sh
terraform state list
```

Show specific resource:

```sh
terraform state show aws_instance.web
```

---

# 🛠 7. Common Remote State Errors & Fixes

| Error                 | Reason                            | Fix                          |
| --------------------- | --------------------------------- | ---------------------------- |
| `Error locking state` | Someone else is running Terraform | Wait or remove lock manually |
| `Access Denied`       | Wrong IAM permissions             | Assign S3 + DynamoDB access  |
| `State file corrupt`  | Manual edits or conflicts         | Restore from versioning      |

---

# 🧠 8. IAM Policy Required for Terraform State

Terraform needs access to:

* S3 bucket
* DynamoDB table

### IAM Permissions

```json
{
  "Effect": "Allow",
  "Action": [
    "s3:PutObject",
    "s3:GetObject",
    "s3:DeleteObject",
    "s3:ListBucket",
    "dynamodb:PutItem",
    "dynamodb:GetItem",
    "dynamodb:DeleteItem",
    "dynamodb:UpdateItem"
  ],
  "Resource": "*"
}
```



🔥 A complete project using S3 + DynamoDB backend
