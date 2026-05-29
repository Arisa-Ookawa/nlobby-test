resource "aws_ecs_cluster" "this" {
  name = "${var.common.project}-${var.common.environment}-ws-cluster-${var.sfx}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}