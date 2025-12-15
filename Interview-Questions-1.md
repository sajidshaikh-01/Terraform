# 🚀 Terraform Most Asked Interview Scenario Questions — README
---
## 1️⃣ Scenario: You ran `terraform apply` and it failed in the middle. What happens?

**Answer:**
Terraform may have created some resources and failed on others. The successfully created resources are already tracked in the state file.

On the next run:

* Terraform reads the state
* Compares desired vs actual state
* Continues from where it failed

**Key Point:**

> Terraform is state-driven, not execution-driven.

---

## 2️⃣ Scenario: Two engineers run `terraform apply` at the same time. What happens?

**Answer:**
If **state locking** is enabled (recommended), one engineer gets the lock and the other must wait.

If locking is NOT enabled:

* State corruption may occur
* Infrastructure may become inconsistent

**Best Practice:**

> Always use remote backend with state locking (S3 + DynamoDB).

---

## 3️⃣ Scenario: Someone manually deleted a resource from AWS console. What happens next?

**Answer:**
Terraform detects **configuration drift** during the next `plan` or `apply`.

Terraform will:

* Show the missing resource in `terraform plan`
* Recreate it on `terraform apply`

**Key Concept:**

> Terraform enforces desired state.

---

## 4️⃣ Scenario: You want different instance types for dev and prod using the same code.

**Answer:**
Use one of the following:

* Terraform workspaces
* Variables with different `.tfvars` files
* Conditional expressions

**Example:**

```hcl
instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
```

---

## 5️⃣ Scenario: Terraform state file got deleted. What will you do?

**Answer:**
If using remote backend with versioning:

* Restore previous state from S3 versioning

If no backup exists:

* Import resources using `terraform import`
* Rebuild state manually

**Interview Tip:**

> This is why remote state with versioning is mandatory.

---

## 6️⃣ Scenario: You need to share Terraform state across multiple modules.

**Answer:**
Use **remote state data source**.

```hcl
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tf-state-bucket"
    key    = "vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}
```

---

## 7️⃣ Scenario: Terraform keeps recreating a resource even though no change was made.

**Answer:**
Possible reasons:

* Non-deterministic values (timestamps, random IDs)
* Manual changes outside Terraform
* Computed fields changing

**Fix:**

* Use `lifecycle { ignore_changes = [...] }`

---

## 8️⃣ Scenario: You need to prevent accidental deletion of production resources.

**Answer:**
Use lifecycle rules:

```hcl
lifecycle {
  prevent_destroy = true
}
```

Terraform will block deletion even if someone runs `terraform destroy`.

---

## 9️⃣ Scenario: You want to deploy the same infra to multiple environments.

**Answer:**
Recommended approaches:

* Folder-based environments (best practice)
* Terraform Cloud workspaces
* Separate backend keys per environment

Avoid relying only on CLI workspaces for large teams.

---

## 🔟 Scenario: Terraform plan shows changes but you don’t want to apply them immediately.

**Answer:**
Save the plan file:

```sh
terraform plan -out=tfplan
terraform apply tfplan
```

Ensures what you reviewed is exactly what gets applied.

---

## 1️⃣1️⃣ Scenario: Secrets are required in Terraform. How do you handle them?

**Answer:**

* Never store secrets in `.tf` files
* Use Vault, AWS Secrets Manager, or SSM
* Fetch secrets using data sources
* Secure Terraform state

---

## 1️⃣2️⃣ Scenario: Terraform apply is slow. How do you optimize it?

**Answer:**

* Reduce unnecessary resources
* Use targeted apply carefully
* Optimize provider configs
* Use parallelism (`-parallelism` flag)

---

## 1️⃣3️⃣ Scenario: You need to update only one resource without touching others.

**Answer:**
Use targeted apply (with caution):

```sh
terraform apply -target=aws_instance.web
```

**Warning:**

> Overuse of `-target` can break dependency graph.

---

## 1️⃣4️⃣ Scenario: Terraform provider version upgrade broke the deployment.

**Answer:**

* Lock provider versions using `required_providers`
* Test upgrades in non-prod
* Use version constraints

---

## 1️⃣5️⃣ Scenario: You are asked why provisioners are avoided in production.

**Answer:**
Provisioners are not idempotent, depend on SSH, and break Terraform’s declarative model.

**Preferred Alternatives:**

* User data
* Ansible
* Packer

---

## 🧠 Rapid-Fire Interview One-Liners

* Terraform is declarative, not imperative
* State is the source of truth
* Remote state is mandatory in production
* Provisioners are last resort
* Terraform manages infra, not software

