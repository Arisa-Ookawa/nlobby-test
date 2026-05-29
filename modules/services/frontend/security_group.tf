/**
# Security Group for ECS
*/
locals {
  upper_project = upper(var.common.project)
}

resource "aws_security_group" "ecs_frontend" {
  name        = "${var.common.environment}-${var.common.project}-frontend-ecs-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} frontend task"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.environment}-${var.common.project}-frontend-ecs-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ecs_frontend_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_frontend.id
}

resource "aws_security_group_rule" "ecs_frontend_ingress" {
  type                     = "ingress"
  from_port                = 3001
  to_port                  = 3001
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_frontend.id
  security_group_id        = aws_security_group.ecs_frontend.id
}

/**
# Security Group for ALB
# NOTE: ECS Security Group ルールのソース SG として利用
*/
resource "aws_security_group" "alb_frontend" {
  name        = "${var.common.project}-${var.common.environment}-frontend-alb-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} frontend ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-frontend-alb-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "alb_frontend_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_frontend.id
}

/**
# Security Group for Internal ALB
*/
resource "aws_security_group" "internal_alb_frontend" {
  name        = "${var.common.project}-${var.common.environment}-frontend-alb-in-sg-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} internal frontend ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-frontend-alb-in-sg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ingress_twingate" {
  description       = "Allow Twingate to connection"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [local.ip_address_list_twingate]
  security_group_id = aws_security_group.internal_alb_frontend.id
}

# outputs問題解消検証
resource "aws_security_group_rule" "ingress_nlobby_nat" {
  # for_each    = [for ip in var.ingress_nlobby_nat : "${ip}/32"]
  description       = "Allow NLobby NatGateway to connection"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.ingress_nlobby_nat
  security_group_id = aws_security_group.internal_alb_frontend.id
}

resource "aws_security_group_rule" "internal_alb_frontend_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.internal_alb_frontend.id
}

/**
# Security Group for Internal ALB
*/
resource "aws_security_group" "vpc_lattice" {
  name        = "${var.common.project}-${var.common.environment}-vpc-lattice-sg-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} vpc lattice"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-vpc-lattice-sg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "vpc_lattice_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc_lattice.id
}

