/**
# ECS
*/
# 自身の Account ID を取得
data "aws_caller_identity" "self" {}

locals {
  environment_map = {
    "staging" = "staging"
    default   = "common"
  }

  task_id = lookup(local.environment_map, var.common.environment, local.environment_map["default"])
}

# タスク定義
resource "aws_ecs_task_definition" "this" {
  family = "${var.common.project}-${var.common.environment}-frontend-task-${var.sfx}"

  requires_compatibilities = ["FARGATE"]

  cpu    = var.ecs_task.cpu
  memory = var.ecs_task.memory

  network_mode = "awsvpc"

  execution_role_arn = aws_iam_role.ecs_frontend_task_role.arn
  task_role_arn      = aws_iam_role.ecs_frontend_task_role.arn

  container_definitions = templatefile("${path.module}/task_definitions/task_definition_${local.task_id}.json",
    {
      # common
      project     = var.common.project
      environment = var.common.environment
      region      = var.common.region
      sfx         = var.sfx

      # コンテナリポジトリ
      repository_url = aws_ecr_repository.this.repository_url
    }
  )

  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-frontend-task-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

# ECS サービス
resource "aws_ecs_service" "this" {
  name = "${var.common.project}-${var.common.environment}-frontend-service-${var.sfx}"

  cluster                            = aws_ecs_cluster.this.name
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = var.ecs_service.desired_count
  enable_ecs_managed_tags            = true
  enable_execute_command             = var.ecs_service.enable_execute_command
  health_check_grace_period_seconds  = var.ecs_service.health_check_grace_period_seconds
  launch_type                        = "FARGATE"
  platform_version                   = var.ecs_service.platform_version
  scheduling_strategy                = "REPLICA"
  task_definition                    = data.aws_ecs_task_definition.this.arn

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "${var.common.project}-${var.common.environment}-frontend-task-${var.sfx}"
    container_port   = 3000
  }

  network_configuration {
    assign_public_ip = var.ecs_service.assign_public_ip
    subnets          = var.ecs_service.subnet_ids
    security_groups  = ["${aws_security_group.ecs_frontend.id}"]
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-frontend-service-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

data "aws_ecs_task_definition" "this" {
  task_definition = aws_ecs_task_definition.this.family
}