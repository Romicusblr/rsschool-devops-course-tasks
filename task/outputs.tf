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
