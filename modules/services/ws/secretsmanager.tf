/** 
# Secret Manager ( backend )
*/
## valkey用 secrets
resource "aws_secretsmanager_secret" "this" {
  name        = "${var.common.project}-${var.common.environment}-ws-secret-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-ws-secret-${var.sfx}"

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ws-secret-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}