# 🚀 Terraform EC2 + S3 Backend Demo

This repository demonstrates how to create an **AWS EC2 instance** using Terraform and manage its **state remotely** using **S3 + DynamoDB** — just like in production environments.

---

## 🧠 What I Learned Today

### ✅ Terraform Basics
- What is Terraform and how it works (Infrastructure as Code)
- Provider, Resource, State, Plan, Apply, and Destroy workflow
- Created a simple EC2 instance with Terraform

### ✅ State Management
- Purpose of `terraform.tfstate` and backup file
- Why state files are critical in Terraform
- How to configure **remote backend** using **S3** and **DynamoDB** for locking

### ✅ Variables & Outputs
- Used `variables.tf` and `terraform.tfvars` for dynamic configuration
- Used `outputs.tf` to print instance details like ID and IP

---

## 🧩 Folder Structure

