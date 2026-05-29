/**
# Security Group for VPC Lattice Resource Gateway
*/
resource "aws_security_group" "vpc_lattice" {
  name        = "${var.common.environment}-${var.common.project}-gw-security-group-${var.sfx}"
  description = "security group for vpc lattice resource gateway"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name        = "${var.common.environment}-${var.common.project}-gw-security-group-${var.sfx}"
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