
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ApplicationID = "2000039"
    }
  }
}
 resource "aws_s3_object" "vector_config" {
  bucket = var.bucket_name
  key    = "vector_config_dev/vector.yaml" 
  source = "vector.yaml"  
  etag   = filemd5("vector.yaml")  
}


module "vector_main" {
 source = "../../module/vector"
 
  # Basic settings
  aws_region             = var.aws_region
  name                   = var.name
  cluster_id             = var.cluster_id
  cluster_name           = var.cluster_name
  execution_role_arn     = var.execution_role_arn
  task_role_arn          = var.task_role_arn
  
  port_mappings          = var.port_mappings
  container_image        = var.container_image
  nginx_image            = var.nginx_image 
  environment            = var.environment
  #target_group_arn_alb = var.target_group_arn_alb
  #target_group_arn_nlb = var.target_group_arn_nlb

  service_count       = var.service_count
  min_capacity        = var.min_capacity
  max_capacity        = var.max_capacity
  cpu_target_value    = var.cpu_target_value
  scale_in_cooldown   = var.scale_in_cooldown
  scale_out_cooldown  = var.scale_out_cooldown  
  #secrets                = var.secrets
  
  # Network configuration
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids  = var.security_group_ids
  assign_public_ip   = var.assign_public_ip
 
 
  # Resource allocation
  task_cpu    = var.task_cpu
  task_memory = var.task_memory
 
  # Additional settings
  vector_version    = var.vector_version
  vector_log_level  = var.vector_log_level
  log_retention_days = var.log_retention_days
 
  # Tags
  tags = var.tags
}
