output "app_private_ip" {
  description = "Private IP address of the app EC2 instance"
  value       = aws_instance.app.private_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion EC2 instance"
  value       = aws_instance.bastion.private_ip
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion EC2 instance"
  value       = aws_instance.bastion.public_ip
}
