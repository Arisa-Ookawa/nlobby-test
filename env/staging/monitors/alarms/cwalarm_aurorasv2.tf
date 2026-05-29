/** 
# CloudWatch Alarm for Aurora Serverless V2 ( nlobby-test-ao-staging-aurora-sv2-1 )
*/
module "monitors_cloudwatch_alarm_rds_postgresql_warn_1" {
  source = "../../../../modules/monitors/cloudwatch/alarm/rds/aurorasv2"

  common = {
    environment = var.environment
  }

  action = {
    alarm        = [data.aws_sns_topic.notify_slack_test_ao.arn]
    ok           = [data.aws_sns_topic.notify_slack_test_ao.arn]
    insufficient = [data.aws_sns_topic.notify_slack_test_ao.arn]
  }

  rds_instance_alarms = [
    {
      aurora_instance_name = "nlobby-test-ao-staging-aurora-sv2-1"
      level                = "warn"

      # CPUUtilization
      rds_cpuutilization_evaluation_periods = "1"
      rds_cpuutilization_period             = "900"
      rds_cpuutilization_statistic          = "Average"
      rds_cpuutilization_threshold          = "85"
      rds_cpuutilization_alarm_description  = ""

      # MemoryUtilization
      rds_freeablememory_evaluation_periods = "1"
      rds_freeablememory_period             = "300"
      rds_freeablememory_statistic          = "Average"
      rds_freeablememory_threshold          = "1677721600" # <= 1.6 GB
      rds_freeablememory_alarm_description  = ""

      # ACUUtilization
      rds_acuutilization_evaluation_periods = "1"
      rds_acuutilization_period             = "900"
      rds_acuutilization_statistic          = "Average"
      rds_acuutilization_threshold          = "30" # <= max 3ACU
      rds_acuutilization_alarm_description  = ""
    }
  ]
}


module "monitors_cloudwatch_alarm_rds_postgresql_fatal_1" {
  source = "../../../../modules/monitors/cloudwatch/alarm/rds/aurorasv2"

  common = {
    environment = var.environment
  }

  action = {
    alarm        = [data.aws_sns_topic.notify_slack_test_ao.arn]
    ok           = [data.aws_sns_topic.notify_slack_test_ao.arn]
    insufficient = [data.aws_sns_topic.notify_slack_test_ao.arn]
  }

  rds_instance_alarms = [
    {
      aurora_instance_name = "nlobby-test-ao-staging-aurora-sv2-1"
      level                = "fatal"

      # CPUUtilization
      rds_cpuutilization_evaluation_periods = "1"
      rds_cpuutilization_period             = "900"
      rds_cpuutilization_statistic          = "Average"
      rds_cpuutilization_threshold          = "90"
      rds_cpuutilization_alarm_description  = ""

      # MemoryUtilization
      rds_freeablememory_evaluation_periods = "1"
      rds_freeablememory_period             = "900"
      rds_freeablememory_statistic          = "Average"
      rds_freeablememory_threshold          = "838860800" # <= 0.8 GB
      rds_freeablememory_alarm_description  = ""

      # ACUUtilization
      rds_acuutilization_evaluation_periods = "1"
      rds_acuutilization_period             = "900"
      rds_acuutilization_statistic          = "Average"
      rds_acuutilization_threshold          = "20" # <= max 3ACU
      rds_acuutilization_alarm_description  = ""
    }
  ]
}



module "monitors_cloudwatch_alarm_rds_postgresql_warn_2" {
  source = "../../../../modules/monitors/cloudwatch/alarm/rds/aurorasv2"

  common = {
    environment = var.environment
  }

  action = {
    alarm        = [data.aws_sns_topic.notify_slack_test_ao.arn]
    ok           = [data.aws_sns_topic.notify_slack_test_ao.arn]
    insufficient = [data.aws_sns_topic.notify_slack_test_ao.arn]
  }

  rds_instance_alarms = [
    {
      aurora_instance_name = "nlobby-test-ao-staging-aurora-sv2-2"
      level                = "warn"

      # CPUUtilization
      rds_cpuutilization_evaluation_periods = "1"
      rds_cpuutilization_period             = "900"
      rds_cpuutilization_statistic          = "Average"
      rds_cpuutilization_threshold          = "85"
      rds_cpuutilization_alarm_description  = ""

      # MemoryUtilization
      rds_freeablememory_evaluation_periods = "1"
      rds_freeablememory_period             = "300"
      rds_freeablememory_statistic          = "Average"
      rds_freeablememory_threshold          = "1677721600" # <= 1.6 GB
      rds_freeablememory_alarm_description  = ""

      # ACUUtilization
      rds_acuutilization_evaluation_periods = "5"
      rds_acuutilization_period             = "300"
      rds_acuutilization_statistic          = "Average"
      rds_acuutilization_threshold          = "30" # <= max 3ACU
      rds_acuutilization_alarm_description  = ""
    }
  ]
}


module "monitors_cloudwatch_alarm_rds_postgresql_fatal_2" {
  source = "../../../../modules/monitors/cloudwatch/alarm/rds/aurorasv2"

  common = {
    environment = var.environment
  }

  action = {
    alarm        = [data.aws_sns_topic.notify_slack_test_ao.arn]
    ok           = [data.aws_sns_topic.notify_slack_test_ao.arn]
    insufficient = [data.aws_sns_topic.notify_slack_test_ao.arn]
  }

  rds_instance_alarms = [
    {
      aurora_instance_name = "nlobby-test-ao-staging-aurora-sv2-2"
      level                = "fatal"

      # CPUUtilization
      rds_cpuutilization_evaluation_periods = "1"
      rds_cpuutilization_period             = "900"
      rds_cpuutilization_statistic          = "Average"
      rds_cpuutilization_threshold          = "90"
      rds_cpuutilization_alarm_description  = ""

      # MemoryUtilization
      rds_freeablememory_evaluation_periods = "1"
      rds_freeablememory_period             = "900"
      rds_freeablememory_statistic          = "Average"
      rds_freeablememory_threshold          = "838860800" # <= 0.8 GB
      rds_freeablememory_alarm_description  = ""

      # ACUUtilization
      rds_acuutilization_evaluation_periods = "1"
      rds_acuutilization_period             = "900"
      rds_acuutilization_statistic          = "Average"
      rds_acuutilization_threshold          = "20" # <= max 3ACU
      rds_acuutilization_alarm_description  = ""
    }
  ]
}
