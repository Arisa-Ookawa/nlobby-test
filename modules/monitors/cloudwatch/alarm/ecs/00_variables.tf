/** 
# Variables for COMMON
*/
variable "common" {
  type = object({
    environment = string
  })

  default = {
    environment = ""
  }
}

variable "sfx" {
  type    = string
  default = "01"
}

/** 
# Variables for CloudWatch Alarm
*/
variable "action" {
  type = object({
    alarm        = list(string)
    ok           = list(string)
    insufficient = list(string)
  })

  default = {
    alarm        = []
    ok           = []
    insufficient = []
  }
}

variable "ecs_alarms" {
  type = list(object({
    ecs_service_name = string
    ecs_cluster_name = string
    level            = string

    # CPUUtilization
    ecs_cpuutilization_evaluation_periods = string
    ecs_cpuutilization_period             = string
    ecs_cpuutilization_statistic          = string
    ecs_cpuutilization_threshold          = string
    ecs_cpuutilization_alarm_description  = string

    # MemoryUtilization
    ecs_memoryutilization_evaluation_periods = string
    ecs_memoryutilization_period             = string
    ecs_memoryutilization_statistic          = string
    ecs_memoryutilization_threshold          = string
    ecs_memoryutilization_alarm_description  = string

    # RunningTaskCount Higher
    ecs_runningtaskcount_higher_evaluation_periods = string
    ecs_runningtaskcount_higher_period             = string
    ecs_runningtaskcount_higher_statistic          = string
    ecs_runningtaskcount_higher_threshold          = string
    ecs_runningtaskcount_higher_alarm_description  = string
    ecs_runningtaskcount_higher_actions_enabled    = bool

    # RunningTaskCount Lower
    ecs_runningtaskcount_lower_evaluation_periods = string
    ecs_runningtaskcount_lower_period             = string
    ecs_runningtaskcount_lower_statistic          = string
    ecs_runningtaskcount_lower_threshold          = string
    ecs_runningtaskcount_lower_alarm_description  = string
    ecs_runningtaskcount_lower_actions_enabled    = bool
  }))
}