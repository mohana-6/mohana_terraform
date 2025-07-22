variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Application name"
  type        = string
}
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

variable "cluster_id" {
  description = "ECS Cluster Name"
  type        = string
  default     = "vector-dev"
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

/*variable "target_group_arn_alb" {
  description = "target_group for the vector"
  type        = string
  default     = "vector"
}*/

variable "target_group_arn_nlb" {
  description = "target_group for the vector"
  type        = string
  default     = "vector"
}

variable "vpc_id" {
  description = "VPC ID where the resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the ECS service"
  type        = list(string)  
  default     = [] 
}
/*variable "svc_account" {
  description = "JFROG repo service account"
  type        = string
}*/

variable "assign_public_ip" {
  description = "Whether to assign public IP addresses to ECS tasks"
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Docker image for the vector"
  type        = string
  default     = "vector"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "port_mappings" {
  description = "A list of port mappings for the ECS container."
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = [
    {
      containerPort = 8686
      hostPort      = 8686
      protocol      = "tcp"
    }
  ]
}

variable "task_cpu" {
  description = "CPU allocation for ECS task"
  type        = string
  default     = "1024"
}

variable "task_memory" {
  description = "Memory allocation for ECS task"
  type        = string
  default     = "2048"
}

variable "vector_version" {
  description = "Version of Vector to deploy"
  type        = string
  default     = "0.39.0-alpine"
}

variable "vector_log_level" {
  description = "Log level for Vector"
  type        = string
  default     = "info"
}

variable "log_retention_days" {
  description = "Retention period for CloudWatch logs (in days)"
  type        = number
  default     = 30
}

# Tags for resources
variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "Logging"
  }
}
variable "execution_role_arn" {
  description = "ARN of the task execution role"
}

variable "task_role_arn" {
  description = "ARN of the task role"
  default     = ""
}
variable "environment" {
  description = "Map of environment variables (not from secrets)"
  type        = map(string)
  default     = {}
}
variable "service_count" {
  description = "Number of task instances to run"
  type        = number
  default     = 1
}

# Autoscaling Configuration
variable "min_capacity" {
  description = "Minimum number of ECS tasks"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks"
  type        = number
  default     = 5
}

variable "cpu_target_value" {
  description = "CPU threshold for autoscaling"
  type        = number
  default     = 60
}

variable "scale_in_cooldown" {
  description = "Cooldown time before scaling in"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Cooldown time before scaling out"
  type        = number
  default     = 300
}

variable "attach_to_lb" {
  description = "Whether to attach this service to a load balancer"
  type        = bool
  default     = false
}

/*variable "nginx_image" {
  description = "nginx image"
  type        = string
}*/