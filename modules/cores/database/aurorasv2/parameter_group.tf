/** 
# Parameter Group
*/
resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.common.project}-${var.common.environment}-aurora-sv2-parameter-group-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-aurora-sv2-parameter-group-${var.sfx}"
  family      = var.rds_cluster_parameter_group.family

  dynamic "parameter" {
    for_each = var.rds_cluster_parameter_group.parameter

    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-aurora-sv2-parameter-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.common.project}-${var.common.environment}-aurora-sv2-pg-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-aurora-sv2-pg-${var.sfx}"
  family      = var.rds_cluster_parameter_group.family

  dynamic "parameter" {
    for_each = var.rds_cluster_parameter_group.parameter

    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-aurora-sv2-pg-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}