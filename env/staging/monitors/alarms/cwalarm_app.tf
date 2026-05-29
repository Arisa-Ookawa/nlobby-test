module "monitors_cloudwatch_alarm_app_fatal" {
  source = "../../../../modules/monitors/cloudwatch/alarm/app"

  common = {
    environment = var.environment
  }

  action = {
    alarm        = [data.aws_sns_topic.notify_slack_test_ao.arn]
    ok           = [data.aws_sns_topic.notify_slack_test_ao.arn]
    insufficient = [data.aws_sns_topic.notify_slack_test_ao.arn]
  }

  app_alarms = [
    {
      ecs_service_name = "nlobby-test-ao-staging-api-01"
      ecs_cluster_name = "nlobby-test-ao-staging-api-01"
      level            = "fatal"

      # error
      ecs_error_evaluation_periods = "1"
      ecs_error_periods            = "900"
      ecs_error_statistic          = "Sum"
      ecs_error_threshold          = "95"
      ecs_error_alarm_description  = "This metric monitors error occurence"
    }
  ]
}