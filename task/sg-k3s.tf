resource "aws_security_group" "k3s_sg" {
  name        = "k3s-sg"
  description = "Security group for the application"
  vpc_id      = aws_vpc.main.id

  # Allow ICMP (ping) access
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # Allow all traffic from VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "k3s-sg"
  })
}
