/** 
# Event Bridge (定期実行)
*/
resource "aws_cloudwatch_event_target" "nlobby_event_regular_execution" {
  rule      = "${var.common.project}-${var.common.environment}-event-regular-execution-${var.sfx}"
  target_id = "PutToECS"
  arn       = aws_ecs_cluster.this.id
  role_arn  = aws_iam_role.ecs_cms_task_role.arn
  #   role_arn = "arn:aws:iam::133775794121:role/nlobby-test-ecs-cms-task-role-staging-01"
  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.this.arn
  }
}

resource "aws_cloudwatch_event_rule" "nlobby_event_regular_execution_staging" {
  name        = "${var.common.project}-${var.common.environment}-event-regular-execution-${var.sfx}"
  description = "NLobby EventBridge rule Regular execution"

  event_pattern = jsonencode({
    detail-type = [
      "NLobby eventbridge"
    ]
  })
}