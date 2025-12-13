## 1️⃣ Why do we integrate Vault with Terraform?

**Answer:**
We integrate Vault with Terraform to **securely manage secrets** such as database passwords, API keys, and tokens without hardcoding them in Terraform code or Git repositories.

Vault provides centralized storage, encryption, access control, and secret rotation, while Terraform dynamically fetches secrets at runtime.

**Interview one‑liner:**

> Vault allows Terraform to use secrets securely without exposing them in code.

---

## 2️⃣ Does Terraform store Vault secrets in the state file?

**Answer:**
Yes. Terraform **can store secret values in the state file** if those values are used by resources.

That’s why in production we must:

* Use encrypted remote backend (S3 + DynamoDB)
* Restrict access to the state file
* Mark outputs as `sensitive = true`

**Important:**

> Vault removes secrets from code, but Terraform state must still be secured.

---

## 3️⃣ How does Terraform authenticate to Vault?

**Answer:**
Terraform authenticates to Vault using supported authentication methods such as:

* AppRole (most common in production)
* AWS IAM authentication
* Kubernetes authentication
* GitHub authentication
* Token authentication (only for dev/testing)

In production, Terraform uses **temporary tokens**, never the root token.

---

## 4️⃣ What is the difference between Vault KV v1 and KV v2?

| Feature        | KV v1     | KV v2       |
| -------------- | --------- | ----------- |
| Versioning     | ❌ No      | ✅ Yes       |
| Secret history | ❌ No      | ✅ Yes       |
| Rollback       | ❌ No      | ✅ Yes       |
| Deletion       | Permanent | Soft delete |

**Interview Answer:**

> KV v2 supports versioning and rollback, making it production‑ready, whereas KV v1 does not.

---

## 5️⃣ How do you avoid secrets leakage in Terraform?

**Answer:**
Secrets leakage is avoided by:

* Using Vault or cloud secrets managers
* Never hardcoding secrets in `.tf` files
* Using encrypted remote backends
* Restricting access to Terraform state
* Marking outputs as sensitive
* Applying least‑privilege IAM policies

---

## 6️⃣ Can Terraform rotate secrets automatically using Vault?

**Answer:**
No. Terraform **does not rotate secrets**.

Vault handles secret rotation (especially dynamic secrets), and Terraform fetches updated secrets on the next run.

**Example:**

> Vault rotates DB credentials → Terraform reads new credentials during next apply.

---

## 7️⃣ Vault vs AWS Secrets Manager — what is the difference?

| Feature         | HashiCorp Vault    | AWS Secrets Manager |
| --------------- | ------------------ | ------------------- |
| Cloud support   | Multi‑cloud        | AWS only            |
| Dynamic secrets | ✅ Yes              | ❌ Limited           |
| Secret engines  | Many               | Few                 |
| Cost            | Free (self‑hosted) | Paid                |
| Control         | Full               | AWS‑managed         |

**Interview Tip:**

> Use Vault for multi‑cloud or advanced secret needs; use AWS Secrets Manager for AWS‑only workloads.

---

## 8️⃣ What happens if Vault is unavailable during `terraform apply`?

**Answer:**
If Vault is unavailable:

* Terraform fails
* Secrets cannot be fetched
* Resources depending on secrets are not created

Terraform does not cache secrets, so Vault must be **highly available** in production.

---

## 9️⃣ Should we store secrets in Terraform variables?

**Answer:**
No. Terraform variables are **not secure** for secrets.

Secrets should always be stored in Vault or a secrets manager and fetched dynamically.

---

* Vault rotates secrets, Terraform consumes them

---

This README is **production‑aligned and interview‑ready**.
