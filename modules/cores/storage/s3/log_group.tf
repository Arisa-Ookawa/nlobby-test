/**
# LogGroup
*/
resource "aws_cloudwatch_log_group" "s3" {
  name = "/s3/${var.common.project}-${var.common.environment}-media-file-${var.sfx}"
  #retention_in_days = var.ecs_log_retention_in_days # TODO: ログローテーションは一旦設定しない

  tags = {
    Name        = "/s3/${var.common.project}-${var.common.environment}-media-file-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}