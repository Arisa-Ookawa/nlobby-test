/** 
# TagetGroup
*/
resource "aws_lb_target_group" "this" {
  name                          = "${var.common.project}-${var.common.environment}-ws-tg-${var.sfx}"
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
    Name        = "${var.common.project}-${var.common.environment}-ws-tg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}