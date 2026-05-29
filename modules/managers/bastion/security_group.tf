/**
# Security Group
*/
resource "aws_security_group" "bastion" {
  name        = "${var.common.project}-${var.common.environment}-bastion-ec2-sg${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-bastion-ec2-sg${var.sfx}"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion-ec2-sg${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}