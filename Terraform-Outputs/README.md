# 📤 Terraform Outputs — Complete README
---
# 🌟 What Are Terraform Outputs?

Terraform **outputs** allow you to extract and display useful information from your deployed infrastructure.

Outputs are commonly used for:

* Showing IPs, URLs, ARNs after deployment
* Passing values between Terraform modules
* Sharing infra details with CI/CD pipelines (Jenkins, GitHub Actions)
* Debugging and verification

---

# 1️⃣ Basic Output Example

### **outputs.tf**

```hcl
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
```

After running:

```sh
terraform apply
```

You will see:

```
instance_public_ip = 13.233.120.45
```

---

# 2️⃣ Output with Description

```hcl
output "bucket_name" {
  value       = aws_s3_bucket.mybucket.bucket
  description = "S3 bucket name created by Terraform"
}
```

This helps document what the output represents.

---

# 3️⃣ Sensitive Output (Hidden in CLI)

Useful for passwords and tokens.

```hcl
output "db_password" {
  value     = random_password.db.result
  sensitive = true
}
```

Terraform will hide it from CLI:

```
<value hidden>
```

---

# 4️⃣ List Output Example

```hcl
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
```

Output:

```
private_subnet_ids = ["subnet-1", "subnet-2", "subnet-3"]
```

---

# 5️⃣ Map Output Example

```hcl
output "instance_details" {
  value = {
    id   = aws_instance.web.id
    type = aws_instance.web.instance_type
    ip   = aws_instance.web.public_ip
  }
}
```

This returns structured information.

---

# 6️⃣ Module Output Example

If you have a module like:

```hcl
module "vpc" {
  source = "./vpc"
}
```

You expose values from the module:

```hcl
output "vpc_id" {
  value = module.vpc.vpc_id
}
```

---

# 7️⃣ How to View Outputs

Show all outputs:

```sh
terraform output
```

Show one output:

```sh
terraform output instance_public_ip
```

---

# 8️⃣ Export Outputs to JSON (CI/CD Friendly)

Useful for pipelines.

```sh
terraform output -json > outputs.json
```

Now another script can parse the output file.

---

# 9️⃣ Real DevOps Use Case

To print the **ALB DNS Name** after deployment:

```hcl
output "alb_dns" {
  value       = aws_lb.app_lb.dns_name
  description = "URL of the application load balancer"
}
```

After apply:

```
alb_dns = myapp-lb-123456.ap-south-1.elb.amazonaws.com
```

