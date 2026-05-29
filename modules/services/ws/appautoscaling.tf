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

resource "aws_appautoscaling_policy" "this" {
  name               = "${var.common.project}-${var.common.environment}-ws-ecs-cpu-tracking-${var.sfx}"
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
  name               = "${var.common.project}-${var.common.environment}-ws-ecs-memory-tracking-${var.sfx}"
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
}