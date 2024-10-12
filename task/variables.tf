variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "bucket_name" {
  type        = string
  description = "State bucket name"
}

variable "github_repository" {
  type        = string
  description = "Github repository name"
}

variable "vpc_ip_block" {
  type        = string
  description = "VPC IP block"
  default = "10.0.0.0/16"
}
