/**
# ALB
*/
resource "aws_lb" "this" {
  name                       = "${var.common.project}-${var.common.environment}-cms-alb-${var.sfx}"
  drop_invalid_header_fields = var.lb.drop_invalid_header_fields
  enable_deletion_protection = var.lb.enable_deletion_protection
  enable_http2               = var.lb.enable_http2
  idle_timeout               = var.lb.idle_timeout
  internal                   = var.lb.internal
  ip_address_type            = var.lb.ip_address_type
  load_balancer_type         = var.lb.load_balancer_type
  security_groups = concat(
    [
      aws_security_group.alb_cms.id
    ],
    var.lb.security_groups
  )
  subnets = var.lb.subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.alb_cms_log.bucket
    enabled = var.lb.access_logs_enabled
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-cms-alb-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/** 
# TagetGroup
*/
resource "aws_lb_target_group" "this" {
  name                          = "${var.common.project}-${var.common.environment}-cms-tg-${var.sfx}"
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
    Name        = "${var.common.project}-${var.common.environment}-cms-tg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# Lister 443
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_https.port
  protocol          = var.lb_listener_https.protocol
  ssl_policy        = var.lb_listener_https.ssl_policy
  certificate_arn   = var.lb_listener_https.certificate_arn

  default_action {
    type             = var.lb_listener_https.default_action.type
    target_group_arn = aws_lb_target_group.this.arn
  }

  lifecycle {
    ignore_changes = [
      default_action # CodeDeploy での B/G Deploy を実装するため Teraform 管理外とする
    ]
  }
}