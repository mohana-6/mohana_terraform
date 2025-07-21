
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Application name"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "dev"
}

variable "cluster_id" {
  description = "Name of the ECS cluster"
  type        = string
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

variable "vector_image" {
  description = "Docker image for Vector"
  type        = string
  default     = "timberio/vector"
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


variable "vector_version" {
  description = "Vector version to deploy"
  type        = string
  default     = "0.39.0-alpine"
}

variable "vector_log_level" {
  description = "Vector log level"
  type        = string
  default     = "info"
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = string
  default     = "1024"  # 1 vCPU
}

variable "task_memory" {
  description = "Memory for the task in MB"
  type        = string
  default     = "2048"  # 2 GB
}

variable "service_count" {
  description = "Number of task instances to run"
  type        = number
  default     = 1
}
/*variable "svc_account" {
  description = "JFROG repo service account"
  type        = string
}*/

variable "vpc_id" {
  description = "VPC ID where the ECS task will run"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs where the ECS task will run"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the ECS service"
  type        = list(string)  
  default     = [] 
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the Fargate task"
  type        = bool
  default     = false
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
    }
  ]
}

variable "log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
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