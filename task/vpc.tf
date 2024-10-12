resource "aws_vpc" "main" {
  cidr_block       = var.vpc_ip_block
  instance_tenancy = "default"
  tags = merge(local.common_tags, {
    Name = "rsschool-devops-vpc"
  })
}
