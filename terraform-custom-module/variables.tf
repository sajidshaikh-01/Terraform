variable "name" {
  type        = string
  description = "EC2 instance name"
}

variable "ami_id" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "subnet_id" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "security_groups" {
  type        = list(string)
}

variable "user_data" {
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
}

