# 🧠 Advanced Terraform Interview Q&A — State, Drift, Modules & CI/CD (README)
---
## 🔹 TERRAFORM STATE (Advanced)

### 1️⃣ What is Terraform state and why is it called the source of truth?

**Answer:**
Terraform state maps Terraform resources to real-world infrastructure. It contains resource IDs, metadata, dependencies, and outputs.

It is called the *source of truth* because Terraform uses the state file to decide:

* What already exists
* What needs to be created, updated, or destroyed

Without state, Terraform cannot manage infrastructure safely.

---

### 2️⃣ How do you protect Terraform state in production?

**Answer:**

* Use remote backend (S3 / Azure Blob / GCS)
* Enable encryption at rest
* Enable versioning
* Enable state locking (DynamoDB / native locking)
* Restrict IAM access (least privilege)

---

### 3️⃣ What happens if Terraform state and real infrastructure go out of sync?

**Answer:**
This is called **configuration drift**.

Terraform detects drift during `terraform plan` and proposes changes to match the desired state.

If drift is intentional, use `lifecycle { ignore_changes = [...] }`.

---

## 🔹 DRIFT & LIFECYCLE MANAGEMENT

### 4️⃣ How do you handle configuration drift in Terraform?

**Answer:**

* Avoid manual changes in cloud console
* Run `terraform plan` regularly
* Use `ignore_changes` for expected drift
* Re-import resources if needed

---

### 5️⃣ What is `lifecycle` block and where is it used?

**Answer:**
The `lifecycle` block controls resource behavior.

Common use cases:

* `prevent_destroy = true`
* `create_before_destroy = true`
* `ignore_changes`

---

## 🔹 MODULES (Advanced)

### 6️⃣ Difference between module and workspace?

**Answer:**

* **Module** → code reusability
* **Workspace** → multiple state files for same code

They solve different problems and are often confused.

---

### 7️⃣ How do you version Terraform modules?

**Answer:**

* Use Git tags (v1.0.0, v1.1.0)
* Pin module versions in `source`

```hcl
source = "git::https://github.com/org/vpc-module.git?ref=v1.2.0"
```

---

### 8️⃣ How do you share outputs between modules?

**Answer:**
Use `terraform_remote_state` data source.

---

## 🔹 PROVIDERS & DEPENDENCIES

### 9️⃣ How does Terraform manage dependencies?

**Answer:**
Terraform builds a dependency graph using:

* Resource references
* Implicit dependencies
* `depends_on` (explicit)

Terraform applies resources in correct order automatically.

---

### 🔟 When should you use `depends_on`?

**Answer:**
Only when Terraform cannot infer dependency automatically, such as:

* External resources
* Data-only dependencies

---

## 🔹 CI/CD WITH TERRAFORM

### 1️⃣1️⃣ How do you use Terraform in CI/CD pipelines?

**Answer:**
Typical flow:

1. `terraform init`
2. `terraform validate`
3. `terraform plan`
4. Manual approval
5. `terraform apply`

State is stored remotely and pipelines use IAM roles or OIDC.

---

### 1️⃣2️⃣ How do you prevent multiple pipelines from modifying infra at the same time?

**Answer:**

* Use remote backend with locking
* Use pipeline-level mutex/locks
* Use Terraform Cloud run queues

---

### 1️⃣3️⃣ How do you handle secrets in Terraform CI/CD?

**Answer:**

* Use Vault / Secrets Manager
* Inject secrets as environment variables
* Never commit secrets
* Secure state backend

---

## 🔹 ADVANCED SCENARIOS

### 1️⃣4️⃣ Why is `terraform apply -target` dangerous?

**Answer:**
It bypasses the dependency graph and may leave infrastructure in an inconsistent state.

Use only for emergency recovery.

---

### 1️⃣5️⃣ What happens if a provider version changes behavior?

**Answer:**

* Lock provider versions
* Test upgrades in non-prod
* Review provider changelogs

---

## 🔥 RAPID INTERVIEW ONE-LINERS

* Terraform is declarative and state-driven
* State must be protected like credentials
* Modules = reusability, workspaces = isolation
* CI/CD must never use local state
* Drift is detected via plan, not apply

---

