/** 
# CloudWatch Alarm for ECS
*/
# CPUUtilization
resource "aws_cloudwatch_metric_alarm" "ecs_cpuutilization" {
  for_each = { for alarm in var.ecs_alarms : alarm.ecs_service_name => alarm }

  alarm_name          = "${each.value.ecs_service_name}-ecs-CPUUtilization-${each.value.level}${var.sfx}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = each.value.ecs_cpuutilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = each.value.ecs_cpuutilization_period
  statistic           = each.value.ecs_cpuutilization_statistic
  threshold           = each.value.ecs_cpuutilization_threshold
  alarm_description   = each.value.ecs_cpuutilization_alarm_description

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    ClusterName = "${each.value.ecs_cluster_name}"
    ServiceName = "${each.value.ecs_service_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.ecs_service_name}-ecs-CPUUtilization-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# MemoryUtilization
resource "aws_cloudwatch_metric_alarm" "ecs_memoryutilization" {
  for_each = { for alarm in var.ecs_alarms : alarm.ecs_service_name => alarm }

  alarm_name          = "${each.value.ecs_service_name}-ecs-MemoryUtilization-${each.value.level}${var.sfx}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = each.value.ecs_memoryutilization_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = each.value.ecs_memoryutilization_period
  statistic           = each.value.ecs_memoryutilization_statistic
  threshold           = each.value.ecs_memoryutilization_threshold
  alarm_description   = each.value.ecs_memoryutilization_alarm_description

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    ClusterName = "${each.value.ecs_cluster_name}"
    ServiceName = "${each.value.ecs_service_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.ecs_service_name}-ecs-MemoryUtilization-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# RunningTaskCount Higher
resource "aws_cloudwatch_metric_alarm" "ecs_runningtaskcount_higher" {
  for_each = { for alarm in var.ecs_alarms : alarm.ecs_service_name => alarm }

  alarm_name          = "${each.value.ecs_service_name}-ecs-RunningTaskCount-higher-${each.value.level}${var.sfx}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = each.value.ecs_runningtaskcount_higher_evaluation_periods
  metric_name         = "RunningTaskCount"
  namespace           = "ECS/ContainerInsights"
  period              = each.value.ecs_runningtaskcount_higher_period
  statistic           = each.value.ecs_runningtaskcount_higher_statistic
  threshold           = each.value.ecs_runningtaskcount_higher_threshold
  alarm_description   = each.value.ecs_runningtaskcount_higher_alarm_description
  actions_enabled     = each.value.ecs_runningtaskcount_higher_actions_enabled

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    ClusterName = "${each.value.ecs_cluster_name}"
    ServiceName = "${each.value.ecs_service_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.ecs_service_name}-ecs-RunningTaskCount-higher-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# RunningTaskCount Lower
resource "aws_cloudwatch_metric_alarm" "ecs_runningtaskcount_lower" {
  for_each = { for alarm in var.ecs_alarms : alarm.ecs_service_name => alarm }

  alarm_name          = "${each.value.ecs_service_name}-ecs-RunningTaskCount-lower-${each.value.level}${var.sfx}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = each.value.ecs_runningtaskcount_higher_evaluation_periods
  metric_name         = "RunningTaskCount"
  namespace           = "ECS/ContainerInsights"
  period              = each.value.ecs_runningtaskcount_lower_period
  statistic           = each.value.ecs_runningtaskcount_lower_statistic
  threshold           = each.value.ecs_runningtaskcount_lower_threshold
  alarm_description   = each.value.ecs_runningtaskcount_lower_alarm_description
  actions_enabled     = each.value.ecs_runningtaskcount_lower_actions_enabled

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    ClusterName = "${each.value.ecs_cluster_name}"
    ServiceName = "${each.value.ecs_service_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.ecs_service_name}-ecs-RunningTaskCount-lower-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}