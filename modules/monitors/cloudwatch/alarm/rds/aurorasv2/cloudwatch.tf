/** 
# CloudWatch Alarm for RDS ( PostgreSQL )
*/
# CPUUtilization
resource "aws_cloudwatch_metric_alarm" "rds_cpuutilization" {
  for_each = { for alarm in var.rds_instance_alarms : alarm.aurora_instance_name => alarm }

  alarm_name          = "${each.value.aurora_instance_name}-rds-CPUUtilization-${each.value.level}${var.sfx}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = each.value.rds_cpuutilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = each.value.rds_cpuutilization_period
  statistic           = each.value.rds_cpuutilization_statistic
  threshold           = each.value.rds_cpuutilization_threshold
  alarm_description   = each.value.rds_cpuutilization_alarm_description

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    DBInstanceIdentifier = "${each.value.aurora_instance_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.aurora_instance_name}-rds-CPUUtilization-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# FreeableMemory
resource "aws_cloudwatch_metric_alarm" "rds_freeablememory" {
  for_each = { for alarm in var.rds_instance_alarms : alarm.aurora_instance_name => alarm }

  alarm_name          = "${each.value.aurora_instance_name}-rds-FreeableMemory-${each.value.level}${var.sfx}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = each.value.rds_freeablememory_evaluation_periods
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = each.value.rds_freeablememory_period
  statistic           = each.value.rds_freeablememory_statistic
  threshold           = each.value.rds_freeablememory_threshold
  alarm_description   = each.value.rds_freeablememory_alarm_description

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    DBInstanceIdentifier = "${each.value.aurora_instance_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.aurora_instance_name}-rds-FreeableMemory-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# ACU Utilization
resource "aws_cloudwatch_metric_alarm" "rds_acuutilization" {
  for_each = { for alarm in var.rds_instance_alarms : alarm.aurora_instance_name => alarm }

  alarm_name          = "${each.value.aurora_instance_name}-rds-ACUUtilization-${each.value.level}${var.sfx}"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "ACUUtilization"
  namespace           = "AWS/RDS"
  period              = each.value.rds_acuutilization_period
  evaluation_periods  = each.value.rds_acuutilization_evaluation_periods
  statistic           = each.value.rds_acuutilization_statistic
  threshold           = each.value.rds_acuutilization_threshold
  alarm_description   = each.value.rds_acuutilization_alarm_description

  alarm_actions             = var.action.alarm
  ok_actions                = var.action.ok
  insufficient_data_actions = var.action.insufficient

  dimensions = {
    DBInstanceIdentifier = "${each.value.aurora_instance_name}"
  }

  lifecycle {
    ignore_changes = [
      datapoints_to_alarm,
    ]
  }

  tags = {
    Name        = "${each.value.aurora_instance_name}-rds-ACUUtilization-${each.value.level}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}
