/** 
# Aurora Serverless V2
*/
resource "aws_rds_cluster" "this" {
  cluster_identifier              = "${var.common.project}-aurora-sv2-${var.common.environment}-${var.sfx}"
  master_username                 = var.rds_cluster.master_username
  master_password                 = random_password.rds_password.result
  engine                          = var.rds_cluster.engine
  engine_version                  = var.rds_cluster.engine_version
  engine_mode                     = var.rds_cluster.engine_mode
  port                            = var.rds_cluster.port
  apply_immediately               = var.rds_cluster.apply_immediately
  kms_key_id                      = local.kms_key_id
  storage_encrypted               = var.rds_cluster.storage_encrypted
  db_subnet_group_name            = aws_db_subnet_group.this.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  preferred_backup_window         = var.rds_cluster.preferred_backup_window
  preferred_maintenance_window    = var.rds_cluster.preferred_maintenance_window
  backup_retention_period         = var.rds_cluster.backup_retention_period
  deletion_protection             = var.rds_cluster.deletion_protection
  skip_final_snapshot             = var.rds_cluster.skip_final_snapshot
  final_snapshot_identifier       = "${var.common.project}-aurora-sv2-${var.common.environment}-${var.sfx}-final-snapshot"
  vpc_security_group_ids          = ["${aws_security_group.rds_this.id}"]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  serverlessv2_scaling_configuration {
    min_capacity = var.rds_cluster_instance.min_capacity
    max_capacity = var.rds_cluster_instance.max_capacity
  }

  lifecycle {
    ignore_changes = [
      master_password,
      availability_zones
    ]
  }

  tags = {
    Name        = "${var.common.project}-aurora-sv2-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_rds_cluster_instance" "nlobby_cluster_instance" {
  for_each = { for idx, instance in var.rds_instances : idx => instance }

  # count             = var.rds_cluster_instance.rds_num_nodes
  # identifier                 = "db-instance${format("%02d", count.index + 1)}"
  # availability_zone = local.availability_zones[count.index % length(local.availability_zones)]
  # instance_class             = var.rds_cluster_instance.instance_class

  identifier         = "${var.common.project}-${var.common.environment}-aurora-sv2-${each.key}"
  cluster_identifier = aws_rds_cluster.this.cluster_identifier
  instance_class     = each.value.instance_class

  engine                     = var.rds_cluster_instance.engine
  engine_version             = var.rds_cluster_instance.engine_version
  db_subnet_group_name       = aws_db_subnet_group.this.name
  db_parameter_group_name    = aws_db_parameter_group.this.name
  publicly_accessible        = var.rds_cluster_instance.publicly_accessible
  auto_minor_version_upgrade = var.rds_cluster_instance.auto_minor_version_upgrade

  tags = {
    Name        = "${var.common.project}-aurora-sv2-instance-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

locals {
  kms_key_id         = var.rds_cluster.storage_encrypted ? data.aws_kms_key.rds.arn : null
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
