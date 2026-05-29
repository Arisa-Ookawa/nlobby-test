/** 
# Secret Manager ( aurorasv2 )
*/
resource "aws_secretsmanager_secret" "aurorasv2_parameter1" {
  name        = "${var.common.project}-${var.common.environment}-parameter-${var.sfx}"
  description = "${var.common.project}-${var.common.environment}-aurorasv2-secrets-${var.sfx}"

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-aurorasv2-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# resource "aws_secretsmanager_secret" "aurorasv2_parameter2" {
#   name   = "${var.common.project}-${var.common.environment}-aurorasv2-${var.sfx}"
#   description = "${var.common.project}-${var.common.environment}-aurorasv2-secrets-${var.sfx}"
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-aurorasv2-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }