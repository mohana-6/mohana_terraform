# ECS Task Definition for Vector on Fargate
resource "aws_ecs_task_definition" "vector_main" {
  family                   = "vector-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  

  container_definitions = jsonencode([
    {
      name      = "vector-${var.name}"
      image     = var.container_image
      essential = true
      stopTimeout = 120

       portMappings = var.port_mappings
      environment = [
        for name, value in var.environment : {
          name  = name
          value = value
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.vector_logs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "vector"
        }
      }
    }

  ])
  tags = var.tags
}

/*# ECS Task Definition for nginx on Fargate

resource "aws_ecs_task_definition" "nginx_proxy" {
  family                   = "nginx-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name      = "nginx-${var.name}"
      image     = var.nginx_image
      essential = true
      stopTimeout = 120

      
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        for name, value in var.environment : {
          name  = name
          value = value
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.nginx_logs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "nginx"
        }
      }
    }

  ])
  tags = var.tags
}*/


# ECS Service for Vector
resource "aws_ecs_service" "vector_main" {
  name            = "vector-${var.name}"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.vector_main.arn
  desired_count   = var.service_count
  launch_type     = "FARGATE"
  tags            = var.tags
  enable_execute_command = true
 
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn_nlb
    container_name   = "vector-${var.name}" 
    container_port   =  var.container_port             
  }
}


/*# ECS Service for Nginx

resource "aws_ecs_service" "nginx_proxy" {
  name            = "nginx-${var.name}"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.nginx_proxy.arn
  desired_count   = var.service_count
  launch_type     = "FARGATE"
  tags            = var.tags
  enable_execute_command = true

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn_alb
    container_name   = "nginx-${var.name}"
    container_port   = 80
  }

}*/

# Define the autoscaling target for Vector ECS service
resource "aws_appautoscaling_target" "vector_main_scaling" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.vector_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

# Define autoscaling policy based on CPU utilization
resource "aws_appautoscaling_policy" "cpu_scaling_policy_dev" {
  name               = "vector-${var.name}-cpu-scaling-dev"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.vector_main_scaling.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = var.cpu_target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
  depends_on = [
    aws_appautoscaling_target.vector_main_scaling  
  ]
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "vector_logs" {
  name              = "/aws/ecs/vector/vector-${var.name}"
  retention_in_days = var.log_retention_days
}

resource "aws_cloudwatch_log_stream" "this_log_stream" {
  name           = "vector-log-stream"  
  log_group_name = aws_cloudwatch_log_group.vector_logs.name  
}

/*resource "aws_cloudwatch_log_group" "nginx_logs" {
  name              = "/aws/ecs/vector/nginx-${var.name}"
  retention_in_days = var.log_retention_days
}

resource "aws_cloudwatch_log_stream" "nginx_log_stream" {
  name           = "nginx-log-stream"  
  log_group_name = aws_cloudwatch_log_group.nginx_logs.name  
}*/
