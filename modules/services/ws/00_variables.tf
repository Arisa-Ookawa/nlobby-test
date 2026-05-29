/**
# Variables for COMMON
*/
variable "common" {
  type = object({
    project     = string
    environment = string
    region      = string
  })

  default = {
    project     = "nlobby"
    environment = ""
    region      = "ap-northeast-1"
  }
}

variable "sfx" {
  type    = string
  default = "01"
}

variable "vpc_id" {
  type    = string
  default = ""
}

/**
# Variables for TargetGroup
*/
variable "lb_target_group" {
  type = object({
    deregistration_delay          = number
    load_balancing_algorithm_type = string
    port                          = number
    protocol                      = string
    protocol_version              = string
    slow_start                    = number
    target_type                   = string
  })

  default = {
    deregistration_delay          = 300
    load_balancing_algorithm_type = "round_robin"
    port                          = 80
    protocol                      = "HTTP"
    protocol_version              = "HTTP1"
    slow_start                    = 0
    target_type                   = "instance"
  }
}

variable "lb_health_check" {
  type = object({
    enabled             = bool
    healthy_threshold   = number
    interval            = number
    matcher             = string
    path                = string
    port                = any
    protocol            = string
    timeout             = number
    unhealthy_threshold = number
  })

  default = {
    enabled             = true
    healthy_threshold   = 2
    interval            = 61
    matcher             = "200"
    path                = "/health"
    port                = 3000
    protocol            = "HTTP"
    timeout             = 60
    unhealthy_threshold = 2
  }
}

variable "lb_listener_http" {
  type = object({
    port     = number
    protocol = string
  })

  default = {
    port     = 80
    protocol = "HTTP"
  }
}

variable "lb_listener_https" {
  type = object({
    port            = number
    protocol        = string
    certificate_arn = string
    ssl_policy      = string
    default_action  = map(string)
  })

  default = {
    port            = 443
    protocol        = "HTTPS"
    certificate_arn = ""
    ssl_policy      = "ELBSecurityPolicy-2016-08"
    default_action = {
      type = "forward"
    }
  }
}

variable "ingress_ierae" {
  type        = list(string)
  default     = []
  description = "CIDR block to allow connection to Ierae"
}

variable "ingress_load_test" {
  type        = list(string)
  default     = []
  description = "CIDR block to allow connection to load test"
}


/**
# Variables for AutoScaling
*/
variable "enable_tracking_memory" {
  type = bool
}

variable "appautoscaling_target" {
  type = object({
    max_capacity       = number
    min_capacity       = number
    service_namespace  = string
    scalable_dimension = string
  })

  default = {
    max_capacity       = 1
    min_capacity       = 1
    service_namespace  = "ecs"
    scalable_dimension = "ecs:service:DesiredCount"
  }
}

variable "appautoscaling_policy" {
  type = object({
    policy_type            = string
    predefined_metric_type = string
    statistic              = string
    target_value           = number
    disable_scale_in       = bool
    scale_in_cooldown      = number
    scale_out_cooldown     = number
  })

  default = {
    policy_type            = "TargetTrackingScaling"
    predefined_metric_type = "ECSServiceAverageCPUUtilization"
    statistic              = "Maximum"
    target_value           = 40
    disable_scale_in       = false
    scale_in_cooldown      = 60
    scale_out_cooldown     = 10
  }
}

/**
# Variables for CloudWatch
*/
variable "cloudwatch_metric_alarm" {
  type = object({
    scale_out_sns_topic_arns = list(string)
    scale_in_sns_topic_arns  = list(string)
    scale_out_threshold_cpu  = number
    scale_in_threshold_cpu   = number
  })
}

# variable "metrics_filter_error" {
#   type = object({
#     pattern   = string
#     namespace = string
#     value     = string
#     unit      = string
#   })
# }

# variable "metrics_filter_fatal" {
#   type = object({
#     pattern   = string
#     namespace = string
#     value     = string
#     unit      = string
#   })
# }

/**
# Variables for ECS
*/
variable "ecs_task" {
  type = object({
    cpu    = number
    memory = number
  })

  default = {
    cpu    = 1024
    memory = 4096
  }
}

variable "ecs_service" {
  type = object({
    desired_count                     = number
    enable_execute_command            = bool
    health_check_grace_period_seconds = number
    subnet_ids                        = list(string)
    assign_public_ip                  = bool
    platform_version                  = string
  })

  default = {
    desired_count                     = 1
    enable_execute_command            = true
    health_check_grace_period_seconds = 30
    subnet_ids                        = []
    assign_public_ip                  = false
    platform_version                  = "LATEST"
  }
}

variable "frontend_security_group" {
  type    = string
  default = ""
}

/**
# Variables for ECR
*/
variable "ecr_repository" {
  type = object({
    image_tag_mutability          = string
    force_delete                  = bool
    scan_on_push                  = bool
    lifecycle_policy_count_number = number
  })

  default = {
    image_tag_mutability          = "MUTABLE"
    force_delete                  = false
    scan_on_push                  = true
    lifecycle_policy_count_number = 30
  }
}

/**
# IAM Role ( GitHub Actions )
*/
variable "repository" {
  type    = string
  default = ""
}

/**
# ElastiCache
*/
variable "elasticache_subnet_group" {
  type = object({
    subnet_ids = list(string)
  })

  default = {
    subnet_ids = []
  }
}

variable "replication_group_id" {
  type = string
}

variable "description" {
  type = string
}

variable "engine" {
  type    = string
  default = "redis"
}

variable "engine_version" {
  type    = string
  default = "6.2"
}

variable "port" {
  type    = number
  default = 6379
}

variable "node_type" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "security_group_names" {
  type    = list(string)
  default = []
}

variable "num_cache_clusters" {
  type    = number
  default = 2
}

variable "parameter_group_name" {
  type    = string
  default = "default.redis6.x"
}

variable "maintenance_window" {
  type    = string
  default = "tue:17:00-tue:18:00"
}

variable "snapshot_retention_limit" {
  type    = number
  default = 5
}

variable "automatic_failover_enabled" {
  type    = bool
  default = true
}

variable "multi_az_enabled" {
  type    = bool
  default = true
}

variable "apply_immediately" {
  type    = bool
  default = true
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = true
}