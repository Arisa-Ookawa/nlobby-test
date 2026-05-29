module "monitors_cloudwatch_alarm_ecs_fatal" {
  source = "./../../../../modules/monitors/cloudwatch/alarm/ecs"

  common = {
    environment = var.environment
  }

  action = {
    alarm        = [data.aws_sns_topic.notify_slack_test_ao.arn]
    ok           = [data.aws_sns_topic.notify_slack_test_ao.arn]
    insufficient = [data.aws_sns_topic.notify_slack_test_ao.arn]
  }

  ecs_alarms = [
    {
      ecs_service_name = "nlobby-test-ao-staging-api-01"
      ecs_cluster_name = "nlobby-test-ao-test-api-staging"
      level            = "fatal"

      # CPUUtilization
      ecs_cpuutilization_evaluation_periods = "1"
      ecs_cpuutilization_period             = "900"
      ecs_cpuutilization_statistic          = "Average"
      ecs_cpuutilization_threshold          = "95"
      ecs_cpuutilization_alarm_description  = ""

      # MemoryUtilization
      ecs_memoryutilization_evaluation_periods = "1"
      ecs_memoryutilization_period             = "900"
      ecs_memoryutilization_statistic          = "Average"
      ecs_memoryutilization_threshold          = "95"
      ecs_memoryutilization_alarm_description  = ""

      # RunningTaskCount Higher
      ecs_runningtaskcount_higher_evaluation_periods = "1"
      ecs_runningtaskcount_higher_period             = "300"
      ecs_runningtaskcount_higher_statistic          = "Average"
      ecs_runningtaskcount_higher_threshold          = "2"
      ecs_runningtaskcount_higher_alarm_description  = ""
      ecs_runningtaskcount_higher_actions_enabled    = false

      # RunningTaskCount Lower
      ecs_runningtaskcount_lower_evaluation_periods = "1"
      ecs_runningtaskcount_lower_period             = "300"
      ecs_runningtaskcount_lower_statistic          = "Average"
      ecs_runningtaskcount_lower_threshold          = "0"
      ecs_runningtaskcount_lower_alarm_description  = ""
      ecs_runningtaskcount_lower_actions_enabled    = true
    }
  ]
}