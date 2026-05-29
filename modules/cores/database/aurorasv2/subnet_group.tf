/** 
# Subnet Group
*/
resource "aws_db_subnet_group" "this" {
  name        = "${var.common.project}-${var.common.environment}-aurora-sv2-test-ao-subnet-group-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-aurora-sv2-test-ao-subnet-group-${var.sfx}"
  subnet_ids  = var.db_subnet_ids

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-aurora-sv2-test-ao-subnet-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}