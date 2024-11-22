resource "aws_lb" "prod_alb" {
  name               = "prod-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_dev_access.id]
  subnets            = [aws_subnet.prod_public_subnet_1.id, aws_subnet.prod_public_subnet_2.id]
}

resource "aws_lb_listener" "prod_alb_listener" {
  load_balancer_arn = aws_lb.prod_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_alb_tg.arn
  }
}

resource "aws_lb_target_group" "prod_alb_tg" {
  name        = "prod-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.prod_vpc.id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
  }
}