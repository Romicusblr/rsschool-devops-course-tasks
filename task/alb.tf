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

# Listener to forward HTTP traffic from port 80 to the target group
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana_target_group.arn
  }
}

# Target Group for Grafana on NodePort 32020
resource "aws_lb_target_group" "grafana_target_group" {
  name        = "grafana-target-group"
  port        = 32020                   # NodePort for Grafana
  protocol    = "HTTP"                  # Use HTTP if Grafana is HTTP-based
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    protocol = "HTTP"
    port     = "32020"                   # Health check on Grafana NodePort
    path     = "/api/health"             # Grafana's health endpoint
    interval = 30
    timeout  = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "grafana-target-group"
  }
}

# Attach all worker nodes to the Grafana Target Group
resource "aws_lb_target_group_attachment" "grafana_targets" {
  count            = var.worker_count
  target_group_arn = aws_lb_target_group.grafana_target_group.arn
  target_id        = aws_instance.k3s_worker[count.index].id
  port             = 32020  # NodePort for Grafana on worker nodes
}

