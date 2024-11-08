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
      name      = "Capstone Web"
      image     = "brandonarbour/capstone-web"
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
  name            = "httpd"
  cluster         = aws_ecs_cluster.dev_ecs_cluster.id
  task_definition = aws_ecs_task_definition.dev_task_def.id
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = aws_subnet.public_subnet[*].id
    security_groups  = [aws_security_group.allow_dev_access.id]
    assign_public_ip = true
  }
}