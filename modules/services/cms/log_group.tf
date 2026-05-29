/**
# LogGroup
*/
resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/${var.common.project}-${var.common.environment}-cms-${var.sfx}"
  #retention_in_days = var.ecs_log_retention_in_days # TODO: ログローテーションは一旦設定しない

  tags = {
    Name        = "/ecs/${var.common.project}-${var.common.environment}-cms-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}