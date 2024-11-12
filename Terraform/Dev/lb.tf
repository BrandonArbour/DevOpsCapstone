resource "aws_lb" "dev_alb" {
  name               = "dev-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_dev_access.id]
  subnets            = [aws_subnet.dev_public_subnet_1.id,aws_subnet.dev_public_subnet_2.id]
}

resource "aws_lb_listener" "dev_alb_listener" {
  load_balancer_arn = aws_lb.dev_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_alb_tg.arn
  }
}

resource "aws_lb_target_group" "dev_alb_tg" {
  name     = "dev-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev_vpc.id
  target_type = "ip"
}