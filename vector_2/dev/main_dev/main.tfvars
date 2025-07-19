aws_region             = "us-east-1"
name                   = "main-dev"
cluster_id             = "arn:aws:ecs:us-east-1:324936657337:cluster/errorbudget-cluster"
cluster_name           = "errorbudget-cluster"
execution_role_arn     = "arn:aws:iam::324936657337:role/errorbudget_ec2_role"
task_role_arn          = "arn:aws:iam::324936657337:role/errorbudget_ec2_role"
#svc_account            = "arn:aws:secretsmanager:us-east-1:178445662108:secret:non-prod-gdap-artifactory-ybrklc"
vpc_id                 = "vpc-0e68bf7f59a3c89d4"
subnet_ids             = ["subnet-0c2a2cfee95ed2a2e" , "subnet-078af0ab3c67821ea"]
security_group_ids     = ["sg-0707c29990939be2b"]
assign_public_ip       = false
bucket_name            = "errorbudget-s3"
container_image        = "324936657337.dkr.ecr.us-east-1.amazonaws.com/errorbudget_repo:vector_mohana"
#nginx_image = "269031123365.dkr.ecr.us-east-1.amazonaws.com/mohana:nginx"
#target_group_arn_alb      = "arn:aws:elasticloadbalancing:us-east-1:324936657337:targetgroup/vector-tg/dd25bfa3edae118d"
#target_group_arn_nlb      = var.target_group_arn_nlb

# Autoscaling Configuration
min_capacity       = 1
max_capacity       = 1
cpu_target_value   = 85
scale_in_cooldown  = 300
scale_out_cooldown = 300
service_count      = 1

port_mappings = [
  {
    containerPort = 8686
    hostPort      = 8686
    protocol      = "tcp"
  },
  {
    containerPort = 9095
    hostPort      = 9095
    protocol      = "tcp"
  },
  {
    containerPort = 9092
    hostPort      = 9092
    protocol      = "tcp"
  },
  {
    containerPort = 80
    hostPort      = 80
    protocol      = "tcp"
  }

]
task_cpu               = "1024"
task_memory            = "2048"
vector_version         = "0.39.0-alpine"
vector_log_level       = "info"
log_retention_days     = 30

# Environment variables
environment = {
  "VECTOR_LOG" = "debug"
  "VECTOR_CONFIG_BUCKET_URL" = "s3://errorbudget-s3/vector_config_dev/vector.yaml"
}

tags = {
  Environment = "dev"
  Project     = "Logging"
  version     = "0.39.0"
}