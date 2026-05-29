resource "aws_ecs_cluster" "this" {
  name = "${var.common.project}-api-${var.common.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}