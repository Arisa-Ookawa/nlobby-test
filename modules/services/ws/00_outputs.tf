/** 
# Outputs
*/
output "aws_lb_target_group" {
  value = aws_lb_target_group.this
}

output "aws_ecr_repository_this" {
  value = aws_ecr_repository.this
}

output "aws_ecs_service_this" {
  value = aws_ecs_service.this
}

output "aws_secretsmanager_secret_this" {
  value = aws_secretsmanager_secret.this
}

output "aws_security_group" {
  value = aws_security_group.nlobby_ws_valky
}