/**
# External ALB
*/
resource "aws_lb" "this" {
  name                       = "${var.common.project}-${var.common.environment}-api-alb-${var.sfx}"
  enable_deletion_protection = var.lb.enable_deletion_protection
  idle_timeout               = var.lb.idle_timeout
  internal                   = var.lb.internal
  load_balancer_type         = var.lb.load_balancer_type
  security_groups = concat(
    [
      aws_security_group.alb_api.id,
    ],
    var.lb.security_groups
  )
  subnets = var.lb.subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.alb_api_log.bucket
    enabled = var.lb.access_logs_enabled
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-alb-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/** 
# External TagetGroup
*/
resource "aws_lb_target_group" "this" {
  name                          = "${var.common.project}-${var.common.environment}-api-tg-${var.sfx}"
  deregistration_delay          = var.lb_target_group.deregistration_delay
  load_balancing_algorithm_type = var.lb_target_group.load_balancing_algorithm_type
  port                          = var.lb_target_group.port
  protocol                      = var.lb_target_group.protocol
  protocol_version              = var.lb_target_group.protocol_version
  slow_start                    = var.lb_target_group.slow_start
  target_type                   = var.lb_target_group.target_type
  vpc_id                        = var.vpc_id

  health_check {
    enabled             = var.lb_health_check.enabled
    healthy_threshold   = var.lb_health_check.healthy_threshold
    interval            = var.lb_health_check.interval
    matcher             = var.lb_health_check.matcher
    path                = var.lb_health_check.path
    port                = var.lb_health_check.port
    protocol            = var.lb_health_check.protocol
    timeout             = var.lb_health_check.timeout
    unhealthy_threshold = var.lb_health_check.unhealthy_threshold
  }

  stickiness {
    enabled         = false
    cookie_duration = 86400
    type            = "lb_cookie"
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-tg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/**
# Internal ALB
*/
resource "aws_lb" "internal" {
  name                       = "${var.common.project}-${var.common.environment}-api-in-alb-${var.sfx}"
  enable_deletion_protection = var.lb.enable_deletion_protection
  idle_timeout               = var.lb.idle_timeout
  internal                   = var.lb.internal
  load_balancer_type         = var.lb.load_balancer_type
  security_groups = concat(
    [
      aws_security_group.internal_alb_api.id,
    ],
    var.lb.security_groups
  )
  subnets = var.lb.subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.alb_api_log.bucket
    enabled = var.lb.access_logs_enabled
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-in-alb-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/** 
# Internal TagetGroup
*/
resource "aws_lb_target_group" "internal" {
  name                          = "${var.common.project}-${var.common.environment}-api-in-tg-${var.sfx}"
  deregistration_delay          = var.lb_target_group.deregistration_delay
  load_balancing_algorithm_type = var.lb_target_group.load_balancing_algorithm_type
  port                          = var.lb_target_group.port
  protocol                      = var.lb_target_group.protocol
  protocol_version              = var.lb_target_group.protocol_version
  slow_start                    = var.lb_target_group.slow_start
  target_type                   = var.lb_target_group.target_type
  vpc_id                        = var.vpc_id

  health_check {
    enabled             = var.lb_health_check.enabled
    healthy_threshold   = var.lb_health_check.healthy_threshold
    interval            = var.lb_health_check.interval
    matcher             = var.lb_health_check.matcher
    path                = var.lb_health_check.path
    port                = var.lb_health_check.port
    protocol            = var.lb_health_check.protocol
    timeout             = var.lb_health_check.timeout
    unhealthy_threshold = var.lb_health_check.unhealthy_threshold
  }

  stickiness {
    enabled         = false
    cookie_duration = 86400
    type            = "lb_cookie"
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-in-tg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}