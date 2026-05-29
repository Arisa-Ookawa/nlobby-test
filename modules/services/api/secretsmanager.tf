/** 
# Secret Manager ( backend )
*/
## api用 secrets
resource "aws_secretsmanager_secret" "this" {
  name        = "${var.common.project}-${var.common.environment}-api-secret-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-api-secret-${var.sfx}"

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-secret-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}