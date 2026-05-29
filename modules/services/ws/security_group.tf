/**
# Security Group for ECS
*/
locals {
  upper_project = upper(var.common.project)
}

resource "aws_security_group" "ecs_ws" {
  name        = "${var.common.environment}-${var.common.project}-ws-ecs-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} ws task"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.environment}-${var.common.project}-ws-ecs-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ecs_ws_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_ws.id
}

resource "aws_security_group_rule" "ecs_ws_ingress" {
  type                     = "ingress"
  from_port                = 3003
  to_port                  = 3003
  protocol                 = "tcp"
  source_security_group_id = var.frontend_security_group
  security_group_id        = aws_security_group.ecs_ws.id
}

/** 
# SecurityGroup ( Valkyの為のSG )
*/
resource "aws_security_group" "nlobby_ws_valky" {
  name        = "${var.common.project}-${var.common.environment}-ws-valky-${var.sfx}"
  description = "Allow to Valky"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ws-valky-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ingress_valky_6379" {
  description              = "Allow Valky to connection"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nlobby_ws_valky.id
  source_security_group_id = aws_security_group.ecs_ws.id
}

resource "aws_security_group_rule" "ingress_valky_6380" {
  description              = "Allow Valky to connection"
  type                     = "ingress"
  from_port                = 6380
  to_port                  = 6380
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nlobby_ws_valky.id
  source_security_group_id = aws_security_group.ecs_ws.id
}

resource "aws_security_group_rule" "egress_valky_global" {
  description       = "Allow Global connection"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlobby_ws_valky.id
}
