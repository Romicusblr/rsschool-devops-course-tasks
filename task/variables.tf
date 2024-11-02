variable "vpc_ip_block" {
  type        = string
  description = "VPC IP block"
}

variable "public_key" {
  type        = string
  description = "Public SSH key"
}

variable "worker_count" {
  description = "Number of worker nodes for the k3s cluster"
  type        = number
  default     = 2  # Change this as per your requirement
}
