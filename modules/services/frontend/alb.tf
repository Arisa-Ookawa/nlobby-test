/**
# External ALB
*/
resource "aws_lb" "this" {
  name                       = "${var.common.project}-${var.common.environment}-web-${var.sfx}"
  drop_invalid_header_fields = var.lb.drop_invalid_header_fields
  enable_deletion_protection = var.lb.enable_deletion_protection
  enable_http2               = var.lb.enable_http2
  idle_timeout               = var.lb.idle_timeout
  internal                   = var.lb.internal
  ip_address_type            = var.lb.ip_address_type
  load_balancer_type         = var.lb.load_balancer_type
  enable_waf_fail_open       = var.lb.enable_waf_fail_open
  security_groups = concat(
    [
      aws_security_group.alb_frontend.id
    ],
    var.lb.security_groups
  )
  subnets = var.lb.subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.alb_frontend_log.bucket
    enabled = var.lb.access_logs_enabled
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-web-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/** 
# External TagetGroup
*/
resource "aws_lb_target_group" "this" {
  name                          = "${var.common.project}-${var.common.environment}-web-${var.sfx}"
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

  lifecycle {
    create_before_destroy = true
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-web-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}