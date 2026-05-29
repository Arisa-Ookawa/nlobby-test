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
    project     = "nlobby-test"
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
# Variables for ALB
*/
variable "lb" {
  type = object({
    drop_invalid_header_fields = bool
    enable_deletion_protection = bool
    enable_http2               = bool
    idle_timeout               = number
    internal                   = bool
    ip_address_type            = string
    load_balancer_type         = string
    security_groups            = list(string)
    subnet_ids                 = list(string)
    access_logs_enabled        = bool
  })

  default = {
    drop_invalid_header_fields = false
    enable_deletion_protection = false # NOTE: 検証の為、削除保護の無効化
    enable_http2               = true
    idle_timeout               = 600
    internal                   = false
    ip_address_type            = "ipv4"
    load_balancer_type         = "application"
    security_groups            = []
    subnet_ids                 = []
    access_logs_enabled        = true
  }
}

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
    deregistration_delay          = 60
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
    path                = "/admin/v2/health"
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
    ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
    default_action = {
      type = "forward"
    }
  }
}

/**
# Variables for AutoScaling
*/
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
    scale_in_cooldown  = number
    scale_out_cooldown = number
  })

  default = {
    scale_in_cooldown  = 300
    scale_out_cooldown = 10
  }
}

variable "cloudwatch_metric_alarm" {
  type = object({
    scale_out_sns_topic_arns = list(string)
    scale_in_sns_topic_arns  = list(string)
    scale_out_threshold_cpu  = number
    scale_in_threshold_cpu   = number
  })
}

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
  })

  default = {
    desired_count                     = 1
    launch_type                       = "FARGATE"
    enable_execute_command            = true
    health_check_grace_period_seconds = 30
    subnet_ids                        = []
    assign_public_ip                  = false
  }
}

/**
# Variables for Task Environment
*/
variable "db_info" {
  type = object({
    app_db_url = string
  })

  default = {
    app_db_url = "nlobby-aurora-test-ao-staging.cluster-cix0o9a55uzl.ap-northeast-1.rds.amazonaws.com"
  }
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
    force_delete                  = true # NOTE: 検証用で削除保護を無効
    scan_on_push                  = true
    lifecycle_policy_count_number = 30
  }
}

/**
# Variables for S3
*/
variable "s3_bucket_force_destroy" {
  type    = bool
  default = true # NOTE: 検証の為、削除保護を無効化
}

variable "versioning_configuration" {
  type    = string
  default = "Disabled"
}

variable "ecs_cms_to_secrets" {
  type    = list(string)
  default = [""]
}