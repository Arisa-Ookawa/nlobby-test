/**
# ElastiCache Subnet Group
*/
resource "aws_elasticache_subnet_group" "this" {
  name        = "${var.common.project}-${var.common.environment}-ws-subnet-group-${var.sfx}"
  description = "Subnet group for ElastiCache Redis"
  subnet_ids  = var.elasticache_subnet_group.subnet_ids

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ws-subnet-group-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
    UpdateDate  = "20260501"
  }
}

/**
# ElastiCache Replication Group for Websocket
*/
resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.replication_group_id
  description                = var.description
  engine                     = var.engine
  engine_version             = var.engine_version
  port                       = var.port
  node_type                  = var.node_type
  subnet_group_name          = var.subnet_group_name
  security_group_names       = var.security_group_names
  security_group_ids         = [aws_security_group.nlobby_ws_valky.id]
  num_cache_clusters         = var.num_cache_clusters
  parameter_group_name       = var.parameter_group_name
  maintenance_window         = var.maintenance_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
}