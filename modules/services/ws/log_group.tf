# /**
# # LogGroup
# */
# resource "aws_cloudwatch_log_group" "ecs_ws" {
#   name = "/ecs/${var.common.project}-${var.common.environment}-ws-log-group-${var.sfx}"
# 
#   tags = {
#     Name        = "/ecs/${var.common.project}-${var.common.environment}-ws-log-group-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# /** 
# # CloudWatch Metrics Fileter for ECS
# */
# resource "aws_cloudwatch_log_metric_filter" "error_fileter" {
#   name           = "${var.common.project}-${var.common.environment}-ws-log-group-error"
#   pattern        = var.metrics_filter_error.pattern
#   log_group_name = aws_cloudwatch_log_group.ecs_ws.name
# 
#   metric_transformation {
#     name      = "${var.common.project}-${var.common.environment}-ws-log-group-error"
#     namespace = var.metrics_filter_error.namespace
#     value     = var.metrics_filter_error.value
#     unit      = var.metrics_filter_error.unit
#   }
# }
# 
# resource "aws_cloudwatch_log_metric_filter" "fatal_fileter" {
#   name           = "${var.common.project}-${var.common.environment}-ws-log-group-fatal"
#   pattern        = var.metrics_filter_fatal.pattern
#   log_group_name = aws_cloudwatch_log_group.ecs_ws.name
# 
#   metric_transformation {
#     name      = "${var.common.project}-${var.common.environment}-ws-log-group-fatal"
#     namespace = var.metrics_filter_fatal.namespace
#     value     = var.metrics_filter_fatal.value
#     unit      = var.metrics_filter_error.unit
#   }
# }
