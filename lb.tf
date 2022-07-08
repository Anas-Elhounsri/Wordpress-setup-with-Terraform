resource "aws_lb" "wp_lb" {
  name               = "wplb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = [aws_subnet.wpsubnet-1.id, aws_subnet.wpsubnet-2.id, aws_subnet.wpsubnet-3.id]
  enable_http2       = false
  enable_deletion_protection = false

  tags = {
    Name = "wp_lb"
  }
}

resource "aws_lb_target_group" "lb_t" {
  name     = "sharepoint-web-servers-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.wp_vpc.id
}

resource "aws_lb_listener" "lb_l" {
  load_balancer_arn = aws_lb.wp_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_t.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.lb_t.arn
  target_id        = aws_instance.wp_ec2_terra.id
  port             = 80
}

