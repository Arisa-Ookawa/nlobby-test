/**
# Security Group for ECS
*/
locals {
  upper_project = upper(var.common.project)
}

resource "aws_security_group" "ecs_cms" {
  name        = "${var.common.environment}-${var.common.project}-cms-ecs-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} cms task"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.environment}-${var.common.project}-cms-ecs-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ecs_cms_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_cms.id
}

resource "aws_security_group_rule" "ecs_cms_ingress" {
  type                     = "ingress"
  from_port                = 3002
  to_port                  = 3002
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_cms.id
  security_group_id        = aws_security_group.ecs_cms.id
}

/**
# Security Group for ALB
# NOTE: ECS Security Group ルールのソース SG として利用
*/
resource "aws_security_group" "alb_cms" {
  name        = "${var.common.project}-${var.common.environment}-cms-alb-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} cms ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-cms-alb-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "alb_cms_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_cms.id
}