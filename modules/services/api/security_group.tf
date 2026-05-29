/**
# Security Group for ECS
*/
locals {
  upper_project = upper(var.common.project)
}

resource "aws_security_group" "ecs_api" {
  name        = "${var.common.environment}-${var.common.project}-api-ecs-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} api task"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.environment}-${var.common.project}-api-ecs-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ecs_api_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_api.id
}

resource "aws_security_group_rule" "ecs_api_ingress" {
  description              = "Allow External ALB to connection"
  type                     = "ingress"
  from_port                = 3001
  to_port                  = 3001
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_api.id
  security_group_id        = aws_security_group.ecs_api.id
}

resource "aws_security_group_rule" "ingress_internal_lb" {
  description              = "Allow Internal ALB to connection"
  type                     = "ingress"
  from_port                = 3001
  to_port                  = 3001
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.internal_alb_api.id
  security_group_id        = aws_security_group.ecs_api.id
}

/**
# Security Group for External ALB
# NOTE: MicroCMSなどからアクセスを許可する為の外部用LBのSGとして利用
*/
resource "aws_security_group" "alb_api" {
  name        = "${var.common.project}-${var.common.environment}-api-alb-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} api ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-alb-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "api_ingress_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow access from external sources, specifically from MicroCMS. Authentication is handled on the application side."
  security_group_id = aws_security_group.alb_api.id
}

# resource "aws_security_group_rule" "alb_api_ingress" {
#   description       = "Allow Twingate to connection"
#   type              = "ingress"
#   from_port         = 3001
#   to_port           = 3001
#   protocol          = "-1"
#   cidr_blocks       = local.ip_address_list_twingate
#   security_group_id = aws_security_group.alb_api.id
# }

resource "aws_security_group_rule" "alb_api_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_api.id
}

/**
# Security Group for Internal ALB
# NOTE: 内部用LBのSGとして利用
*/
resource "aws_security_group" "internal_alb_api" {
  name        = "${var.common.project}-${var.common.environment}-api-alb-in-security-group-${var.sfx}"
  description = "[${var.common.environment}] ${local.upper_project} api Internal ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-alb-in-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# resource "aws_security_group_rule" "ingress_nlobby_nat" {
#   description       = "Allow NLobby NatGateway to connection"
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = var.ingress_nlobby_nat
#   security_group_id = aws_security_group.internal_alb_api.id
# }

# resource "aws_security_group_rule" "ingress_vpc_lattice" {
#   description              = "Allow vpc lattice to connection"
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   source_security_group_id = var.ingress_vpc_lattice
#   security_group_id        = aws_security_group.internal_alb_api.id
# }

resource "aws_security_group_rule" "internal_alb_api_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.internal_alb_api.id
}
