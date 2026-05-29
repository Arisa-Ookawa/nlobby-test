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

variable "app_alarms" {
  type = list(object({
    ecs_service_name = string
    ecs_cluster_name = string
    level            = string

    # Error
    ecs_error_evaluation_periods = string
    ecs_error_periods            = string
    ecs_error_statistic          = string
    ecs_error_threshold          = string
    ecs_error_alarm_description  = string
  }))
}