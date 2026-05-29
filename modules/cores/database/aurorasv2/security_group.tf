/**
# Security Group
*/
resource "aws_security_group" "rds_this" {
  name        = "${var.common.project}-${var.common.environment}-aurora-sv2-test-ao-security-group-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-aurora-sv2-test-ao-security-group-${var.sfx}"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-aurora-sv2-test-ao-security-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.rds_cluster.port
  to_port           = var.rds_cluster.port
  protocol          = "tcp"
  cidr_blocks       = var.db_ingress_cidr_blocks
  security_group_id = aws_security_group.rds_this.id
}