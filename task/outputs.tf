output "bastion_public_ip" {
  description = "Public IP address of the bastion EC2 instance"
  value       = aws_instance.bastion.public_ip
}

output "lb_public_ip" {
  description = "Public IP address of load balancer"
  value       = aws_lb.app_alb.dns_name
}

