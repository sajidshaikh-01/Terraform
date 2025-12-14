# 🔐 Terraform + Vault Integration — Secrets Management Complete README
---
# 🌟 Why Secrets Management Is Needed

In real production environments, we deal with secrets like:

* Database passwords
* API keys
* Cloud credentials
* TLS certificates
* Tokens

❌ **Hardcoding secrets in Terraform files, GitHub, or CI/CD pipelines is a security risk**.

This is where **HashiCorp Vault** comes in.

---

# 🧠 What Is HashiCorp Vault?

Vault is a **centralized secrets management tool** that:

* Securely stores secrets
* Encrypts secrets at rest and in transit
* Provides fine-grained access control
* Generates dynamic secrets
* Integrates natively with Terraform

---

# 🏗️ Terraform + Vault Architecture (Concept)

Terraform never stores secrets directly.

Flow:

1. Terraform authenticates to Vault
2. Vault returns secrets securely
3. Terraform uses secrets at runtime
4. Secrets are NOT hardcoded

---

# ⚠️ Important Security Rule

> Terraform **state file can still contain secrets**.

✅ Always use:

* Remote backend (S3 + DynamoDB)
* Encryption
* Restricted IAM access

---

# 📦 Step-by-Step: Terraform Vault Integration

---

## Step 1️⃣ — Install Vault

```sh
sudo yum install -y vault
vault version
```

Or use Docker:

```sh
docker run -d --name vault -p 8200:8200 vault
```

---

## Step 2️⃣ — Start Vault (Dev Mode for Learning)

```sh
vault server -dev
```

Vault runs at:

```
http://127.0.0.1:8200
```

Dev mode auto-unseals Vault and prints root token.

---

## Step 3️⃣ — Set Vault Environment Variables

```sh
export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="<root-token>"
```

---

## Step 4️⃣ — Store Secrets in Vault

Enable KV secrets engine:

```sh
vault secrets enable -path=secret kv
```

Add secrets:

```sh
vault kv put secret/db \
  username="admin" \
  password="StrongPassword123"
```

---

# 🔗 Step 5️⃣ — Configure Vault Provider in Terraform

## providers.tf

```hcl
provider "vault" {
  address = "http://127.0.0.1:8200"
}
```

Terraform automatically reads `VAULT_TOKEN` from environment.

---

# 📥 Step 6️⃣ — Read Secrets from Vault

## data.tf

```hcl
data "vault_kv_secret_v2" "db_creds" {
  mount = "secret"
  name  = "db"
}
```

---

# 🧩 Step 7️⃣ — Use Vault Secrets in Terraform Resources

```hcl
resource "aws_db_instance" "example" {
  engine   = "mysql"
  username = data.vault_kv_secret_v2.db_creds.data["username"]
  password = data.vault_kv_secret_v2.db_creds.data["password"]
}
```

Secrets are fetched securely at runtime.

---

# 🔒 Step 8️⃣ — Mark Outputs as Sensitive

```hcl
output "db_password" {
  value     = data.vault_kv_secret_v2.db_creds.data["password"]
  sensitive = true
}
```

---

# 🛡️ Step 9️⃣ — Vault Authentication (Production)

❌ Do NOT use root token in production.

Common auth methods:

* AWS IAM Auth
* Kubernetes Auth
* AppRole Auth
* GitHub Auth

Example: AppRole (concept)

* Terraform authenticates using role_id + secret_id
* Vault issues temporary token

---

# 🧠 Real DevOps Use Cases

| Use Case          | Benefit                 |
| ----------------- | ----------------------- |
| DB credentials    | No hardcoding passwords |
| API tokens        | Centralized management  |
| TLS certs         | Auto-rotation           |
| Cloud credentials | Temporary credentials   |

---

# ⚠️ Common Mistakes to Avoid

❌ Hardcoding secrets in `.tf` files
❌ Committing secrets to GitHub
❌ Using Vault dev mode in production
❌ Ignoring Terraform state security

---


