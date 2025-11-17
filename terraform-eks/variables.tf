variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "desired_size" {
  default = 2
}

variable "max_size" {
  default = 4
}

variable "min_size" {
  default = 1
}
