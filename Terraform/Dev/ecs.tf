resource "aws_ecs_cluster" "dev_ecs_cluster" {
  name = "dev_ecs_cluster"
}

resource "aws_ecs_task_definition" "dev_task_def" {
  family                   = "Web-Server"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "DevCapstoneWeb"
      image     = var.dev_image_name
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "dev_ecs_service" {
  name            = "DevCapstoneWeb"
  cluster         = aws_ecs_cluster.dev_ecs_cluster.id
  task_definition = aws_ecs_task_definition.dev_task_def.id
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [aws_subnet.dev_public_subnet_1.id, aws_subnet.dev_public_subnet_2.id]
    security_groups  = [aws_security_group.dev_ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.dev_alb_tg.arn
    container_name   = "DevCapstoneWeb"
    container_port   = 80
  }
}