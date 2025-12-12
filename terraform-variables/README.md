Variables allow you to parameterize Terraform code so you don’t hard-code values.

1. Basic Variable
variable "instance_type" {
  type    = string
  default = "t2.micro"
}


2. Variable Without Default (Mandatory)
variable "region" {
  type = string
}


3. Passing Variables
terraform apply -var="region=us-east-1"



4. Types of Variables
✔ String
variable "env" {
  type = string
}


✔ Number
variable "port" {
  type = number
}


✔ Boolean
variable "enable_monitoring" {
  type    = bool
  default = true
}


✔ List
variable "azs" {
  type = list(string)
}


✔ Map
variable "tags" {
  type = map(string)
}


5. Sensitive Variable
variable "db_password" {
  type      = string
  sensitive = true
}



