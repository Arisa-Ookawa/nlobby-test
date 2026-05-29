/** 
# CloudWatch Alarm for ECS (ERROR Log)
*/
# locals {
#   ecs_app_error_metric_filters = {
#     api = {
#       metric_filter_name    = "ecs-api-app-error"
#       metric_filter_pattern = <<EOF
#       { ($.instanceID = "ecs") && ($.app.error = *) }
#       EOF
#     }
#     cms = {
#       metric_filter_name    = "ecs-cms-app-error"
#       metric_filter_pattern = <<EOF
#       { ($.instanceID = "ecs") && ($.app.error = *) }
#       EOF
#     }
#     frontend = {
#       metric_filter_name    = "ecs-frontend-app-error"
#       metric_filter_pattern = <<EOF
#       { ($.instanceID = "ecs") && ($.app.error = *) }
#       EOF
#     }
#     aurorasv2 = {
#       metric_filter_name    = "aurorasv2-error"
#       metric_filter_pattern = <<EOF
#       { ($.instanceID = "rds") && ($.app.error = *) }
#       EOF
#     }
#   }
# }

resource "aws_cloudwatch_log_metric_filter" "api_error_alarm" {
  # for_each       = local.error_app_metric_filters
  # name           = each.value.metric_filter_name
  # pattern        = each.value.metric_filter_pattern
  name           = "error"
  pattern        = "ERROR"
  log_group_name = "/ecs/nlobby-test-ao-staging-api-01"

  metric_transformation {
    name      = "ErrorLogs"
    namespace = "custom"
    value     = 0
  }
}

# metric-filter.tfで定義したカスタムメトリクス用のアラーム
resource "aws_cloudwatch_metric_alarm" "api_error_alarm" {
  for_each = { for alarm in var.app_alarms : alarm.ecs_service_name => alarm }

  alarm_name          = "${each.value.ecs_service_name}-app-Error-${each.value.level}${var.sfx}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = each.value.ecs_error_evaluation_periods
  metric_name         = "AppError"
  namespace           = "AWS/ECS"
  period              = each.value.ecs_error_periods
  statistic           = each.value.ecs_error_statistic
  threshold           = each.value.ecs_error_threshold
  alarm_description   = each.value.ecs_error_alarm_description

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  tags = {
    Name        = "${each.value.ecs_service_name}-app-Error-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}