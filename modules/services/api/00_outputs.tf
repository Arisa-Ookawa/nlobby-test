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

# output "aws_cloudfront_origin_access_identity" {
#   value = aws_cloudfront_origin_access_identity.maintenance_assets
# }

# output "aws_cloudwatch_event_connection" {
#   value = aws_cloudwatch_event_connection.connection
# }

# output "aws_cloudwatch_event_api_destination" {
#   value = aws_cloudwatch_event_api_destination.batch_event_token_update
# }

# output "aws_security_group_gw_api" {
#   value = aws_security_group.gw_api
# }