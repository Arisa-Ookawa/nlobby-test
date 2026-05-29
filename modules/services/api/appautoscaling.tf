/**
# AutoScaling
*/
resource "aws_appautoscaling_target" "this" {
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

## Auto Scaling
resource "aws_appautoscaling_policy" "this" {
  name               = "${var.common.project}-${var.common.environment}-ecs-api-cpu-tracking-${var.sfx}"
  policy_type        = var.appautoscaling_policy.policy_type
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.appautoscaling_policy.target_value
    scale_in_cooldown  = var.appautoscaling_policy.scale_in_cooldown
    scale_out_cooldown = var.appautoscaling_policy.scale_out_cooldown
  }
}

resource "aws_appautoscaling_policy" "this_memory" {
  name               = "${var.common.project}-${var.common.environment}-ecs-api-memory-tracking-${var.sfx}"
  policy_type        = var.appautoscaling_policy.policy_type
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.appautoscaling_policy.target_value
    scale_in_cooldown  = var.appautoscaling_policy.scale_in_cooldown
    scale_out_cooldown = var.appautoscaling_policy.scale_out_cooldown
  }
  depends_on = [aws_appautoscaling_target.this]
}

resource "aws_appautoscaling_scheduled_action" "scale_out_16am" {
  name               = "scale-out-at-16am"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  schedule = "cron(0 7 28 4 ? 2026)" # 16時に実行

  scalable_target_action {
    min_capacity = 5
    max_capacity = 15
  }
}

resource "aws_appautoscaling_scheduled_action" "scale_in_19pm" {
  name               = "scale-in-at-19am"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  schedule = "cron(0 10 28 4 ? 2026)" # 19時に実行

  scalable_target_action {
    min_capacity = 5
    max_capacity = 15
  }
}

resource "aws_appautoscaling_scheduled_action" "scale_out_17am" {
  name               = "scale-out-at-17am"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  schedule = "cron(0 8 28 4 ? 2026)" # 17時に実行

  scalable_target_action {
    min_capacity = 3
    max_capacity = 10
  }
}

resource "aws_appautoscaling_scheduled_action" "scale_in_18pm" {
  name               = "scale-in-at-18am"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = var.appautoscaling_target.scalable_dimension
  service_namespace  = var.appautoscaling_target.service_namespace

  schedule = "cron(0 9 28 4 ? 2026)" # 18時に実行

  scalable_target_action {
    min_capacity = 3
    max_capacity = 10
  }
}