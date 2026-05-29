/**
# AutoScaling
*/
resource "aws_appautoscaling_target" "cms_target" {
  max_capacity       = var.appautoscaling_target.max_capacity
  min_capacity       = var.appautoscaling_target.min_capacity
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  tags = {
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_appautoscaling_policy" "scale_out" {
  name               = "${var.common.project}-ecs-asg-test-cms-cpu-scale-out-${var.common.environment}-${var.sfx}"
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.appautoscaling_policy.scale_out_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.cms_target]
}

resource "aws_appautoscaling_policy" "scale_in" {
  name               = "${var.common.project}-ecs-asg-test-cms-cpu-scale-in-${var.common.environment}-${var.sfx}"
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.appautoscaling_policy.scale_in_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.cms_target]
}

resource "aws_cloudwatch_metric_alarm" "scale_out" {
  alarm_name          = "${var.common.project}-ecs-asg-test-cms-cpu-scale-out-alarm-${var.common.environment}-${var.sfx}"
  alarm_description   = "[${var.common.environment}] ${var.common.project}-test-cms-${var.common.environment} ECS Service ScaleOut Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  alarm_actions       = concat([aws_appautoscaling_policy.scale_out.arn], var.cloudwatch_metric_alarm.scale_out_sns_topic_arns)
  ok_actions          = var.cloudwatch_metric_alarm.scale_out_sns_topic_arns

  dimensions = {
    "ClusterName" = aws_ecs_cluster.this.name
    "ServiceName" = aws_ecs_service.this.name
  }

  evaluation_periods = 1
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = 60
  statistic          = "Average"
  threshold          = var.cloudwatch_metric_alarm.scale_out_threshold_cpu
  unit               = "Percent"

  tags = {
    Name        = "${var.common.project}-ecs-asg-test-cms-cpu-scale-out-alarm-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_in" {
  alarm_name          = "${var.common.project}-ecs-asg-test-cms-cpu-scale-in-alarm${var.common.environment}-${var.sfx}"
  alarm_description   = "[${var.common.environment}] ${var.common.project}-test-cms-${var.common.environment} ECS Service ScaleIn Alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  alarm_actions       = concat([aws_appautoscaling_policy.scale_in.arn], var.cloudwatch_metric_alarm.scale_in_sns_topic_arns)
  ok_actions          = var.cloudwatch_metric_alarm.scale_in_sns_topic_arns

  dimensions = {
    "ClusterName" = aws_ecs_cluster.this.name
    "ServiceName" = aws_ecs_service.this.name
  }

  evaluation_periods = 1
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = 60
  statistic          = "Average"
  threshold          = var.cloudwatch_metric_alarm.scale_in_threshold_cpu
  unit               = "Percent"

  tags = {
    Name        = "${var.common.project}-ecs-asg-test-cms-cpu-scale-in-alarm-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}