resource "aws_lb" "dev_nlb" {
  name               = "dev-alb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.allow_dev_access.id]
  subnets            = aws_subnet.public_subnet[*].id
}

resource "aws_lb_listener" "dev_nlb_listener" {
  load_balancer_arn = aws_lb.dev_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_nlb_tg.arn
  }
}

resource "aws_lb_target_group" "dev_nlb_tg" {
  name     = "dev-nlb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.dev_vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    port                = "traffic-port"
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}