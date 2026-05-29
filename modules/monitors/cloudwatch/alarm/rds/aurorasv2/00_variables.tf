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

variable "rds_instance_alarms" {
  type = list(object({
    aurora_instance_name = string
    level                = string

    # CPUUtilization
    rds_cpuutilization_evaluation_periods = string
    rds_cpuutilization_period             = string
    rds_cpuutilization_statistic          = string
    rds_cpuutilization_threshold          = string
    rds_cpuutilization_alarm_description  = string

    # FreeableMemory
    rds_freeablememory_evaluation_periods = string
    rds_freeablememory_period             = string
    rds_freeablememory_statistic          = string
    rds_freeablememory_threshold          = string
    rds_freeablememory_alarm_description  = string

    # ACUUtilization
    rds_acuutilization_evaluation_periods = number
    rds_acuutilization_period             = string
    rds_acuutilization_statistic          = string
    rds_acuutilization_threshold          = number
    rds_acuutilization_alarm_description  = string
  }))
}
