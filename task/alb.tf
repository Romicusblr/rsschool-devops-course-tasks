# Security Group for ALB to allow public HTTP access
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB to allow public HTTP access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id
  enable_deletion_protection = false

  tags = {
    Name = "app-alb"
  }
}

# Target Group for worker nodes on NodePort 32000
resource "aws_lb_target_group" "app_target_group" {
  name        = "app-target-group"
  port        = 32000                   # NodePort for your application on the worker nodes
  protocol    = "HTTP"                   # Use HTTP if your app is HTTP-based
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    protocol = "HTTP"
    port     = "32000"                   # Health check on the same NodePort
    path     = "/login"                  # Path to check (modify based on your app's health endpoint)
  }
}

# Attach all worker nodes to the Target Group
resource "aws_lb_target_group_attachment" "app_targets" {
  count            = var.worker_count
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = aws_instance.k3s_worker[count.index].id
  port             = 32000  # NodePort on the worker nodes
}

# Listener to forward HTTP traffic from port 80 to the target group
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}
