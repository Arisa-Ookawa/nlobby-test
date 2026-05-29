resource "aws_ecs_cluster" "this" {
  name = "${var.common.project}-web-${var.common.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}