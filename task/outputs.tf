output "k3s_master_private_ip" {
  description = "Private IP address of the app EC2 instance"
  value       = aws_instance.k3s_master.private_ip
}

output "k3s_worker_private_ips" {
  description = "The private IP addresses of the k3s worker nodes"
  value       = aws_instance.k3s_worker[*].private_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion EC2 instance"
  value       = aws_instance.bastion.private_ip
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion EC2 instance"
  value       = aws_instance.bastion.public_ip
}

output "lb_public_ip" {
  description = "Public IP address of load balancer"
  value       = aws_lb.app_alb.dns_name
}

output "ecr_repository_uri" {
  description = "ECR repository URI"
  value       = aws_ecr_repository.jenkins_app.repository_url
}

output "iam_access_key_id" {
  description = "IAM access key ID"
  value       = aws_iam_access_key.ecr_access_key.id
  sensitive   = true
}

output "iam_secret_access_key" {
  description = "IAM secret access key"
  value       = aws_iam_access_key.ecr_access_key.secret
  sensitive   = true
}
