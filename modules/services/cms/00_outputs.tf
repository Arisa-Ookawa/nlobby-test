/** 
# Outputs
*/
output "aws_lb_this" {
  value = aws_lb.this
}

output "aws_lb_listener_https" {
  value = aws_lb_listener.https
}

output "aws_lb_target_group_this" {
  value = aws_lb_target_group.this
}

output "aws_ecr_repository_this" {
  value = aws_ecr_repository.this
}

output "aws_ecs_service_this" {
  value = aws_ecs_service.this
}

output "aws_cloudwatch_log_group_ecs" {
  value = aws_cloudwatch_log_group.ecs
}