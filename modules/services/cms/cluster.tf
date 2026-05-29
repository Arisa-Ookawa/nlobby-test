resource "aws_ecs_cluster" "this" {
  name = "${var.common.project}-test-cms-${var.common.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}