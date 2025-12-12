# ⚠️ Terraform Provisioners — Complete README

* What Terraform provisioners are
* Why they are NOT recommended in production
* Types of provisioners
* Real examples for each provisioner
* When to use and when NOT to use them

---

# 🌟 What Are Terraform Provisioners?

Provisioners allow Terraform to run **scripts or commands** on a resource *after it is created or before it is destroyed*.

Provisioners behave like:

* Running shell commands
* Copying files
* Executing remote commands via SSH or WinRM

**Terraform officially recommends avoiding provisioners except as a last resort.**

---

# 📌 Types of Provisioners in Terraform

There are **four** main provisioners:

1. `local-exec`
2. `remote-exec`
3. `file`
4. `null_resource` (not a provisioner itself but used with provisioners)

Let’s explore each with examples.

---

# 1️⃣ local-exec Provisioner

Runs commands **on your local machine** (where Terraform is executed).

### **Use Case**

* Trigger a script locally
* Notify external systems (Slack, Jenkins, webhook)
* Output local logs

### **Example**

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo Instance Created: ${self.public_ip} >> output.txt"
  }
}
```

This writes the EC2 public IP to a **local file**.

---

# 2️⃣ remote-exec Provisioner

Runs commands **inside the remote server** using SSH or WinRM.

### **Use Case**

* Install packages
* Configure system
* Run shell commands inside VM

### ⚠️ Not recommended in production (SSH dependencies).

### **Example**

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo systemctl start nginx"
    ]
  }
}
```

---

# 3️⃣ file Provisioner

Copies a file or directory **from local machine → remote server**.

### **Use Case**

* Upload configuration files
* Upload application files
* Push certificates / scripts

### **Example**

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "app/config.yml"
    destination = "/home/ec2-user/config.yml"
  }
}
```

---

# 4️⃣ null_resource (with provisioners)

`null_resource` is a special resource used to execute provisioners **without creating infrastructure**.

Useful for:

* Running scripts in CI/CD
* Triggering actions when variables change
* Running local commands in Terraform workflow

### Example

```hcl
resource "null_resource" "run_script" {
  triggers = {
    build_id = var.build_id
  }

  provisioner "local-exec" {
    command = "bash deploy.sh"
  }
}
```

`triggers` ensures it runs only when values change.

---

# ⚠️ Why Provisioners Are NOT Recommended

Provisioners should be used **rarely** because:

* Not idempotent
* Not predictable
* Failures break Terraform state
* Depend on SSH availability
* Hard to troubleshoot
* Not cloud-native

Provisioners violate Terraform’s declarative model.

---

# ✔ Recommended Alternatives

| Job                  | Recommended Tool        |
| -------------------- | ----------------------- |
| Install packages     | User Data / Ansible     |
| Upload files         | S3 / Git / CI pipeline  |
| Configure OS         | Ansible / Chef / Puppet |
| Build machine images | Packer                  |
| Deploy apps          | CI/CD pipeline          |

Using these tools ensures:

* Idempotency
* No SSH dependency
* Scalable, reliable provisioning

---

# 🧠 Interview Questions on Provisioners

1. What are Terraform provisioners?
2. Why provisioners are not recommended in production?
3. Difference between `local-exec` and `remote-exec`?
4. When should you use `null_resource`?
5. How does `triggers` work inside `null_resource`?
6. What is a better alternative to remote-exec provisioner?
7. How do you provision software without using provisioners?
8. What happens if a provisioner fails during `terraform apply`?
9. Are provisioners idempotent? Why is that important?
10. Explain a real scenario where provisioners might still be needed.

---

# 📝 Summary

| Provisioner   | Runs On       | Purpose                       |
| ------------- | ------------- | ----------------------------- |
| local-exec    | Local machine | Run scripts locally           |
| remote-exec   | Remote server | Install/configure software    |
| file          | Remote server | Copy files                    |
| null_resource | Local         | Trigger scripts without infra |

Provisioners = **use only when no other option exists**.

