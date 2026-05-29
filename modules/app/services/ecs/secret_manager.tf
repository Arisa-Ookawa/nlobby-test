/** 
# Secret Manager ( frontend )
*/
resource "aws_secretsmanager_secret" "api_url" {
  name        = "${var.common.project}-${var.common.environment}-api-url-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-api-url-${var.sfx}"

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-url-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_secretsmanager_secret" "next_public_fullcalendar_license_key" {
  name        = "${var.common.project}-${var.common.environment}-next-public-fullcalendar-license-key-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-next-public-fullcalendar-license-key-${var.sfx}"

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-next-public-fullcalendar-license-key-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}