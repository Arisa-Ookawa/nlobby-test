/**
# Variables for COMMON
*/
variable "common" {
  type = object({
    project     = string
    environment = string
  })

  default = {
    project     = ""
    environment = ""
  }
}

variable "sfx" {
  type    = string
  default = "01"
}

/** 
# Variables for Aurora
*/
variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  type        = list(string)
  default     = []
  description = "Subnet where the DB server is located"
}

variable "rds_cluster_parameter_group" {
  type = object({
    family    = string
    parameter = map(string)
  })
  default = {
    family    = "aurora-postgresql16"
    parameter = {}
  }
}

variable "rds_cluster" {
  type = object({
    master_username              = string
    engine                       = string
    engine_version               = string
    engine_mode                  = string
    port                         = number
    preferred_backup_window      = string
    preferred_maintenance_window = string
    apply_immediately            = bool
    storage_encrypted            = bool
    backup_retention_period      = number
    deletion_protection          = bool
    skip_final_snapshot          = bool
  })

  default = {
    master_username              = "root"
    engine                       = "aurora-postgresql"
    engine_version               = "16.2"
    engine_mode                  = "provisioned"
    port                         = 5432
    preferred_backup_window      = "18:00-19:00"         # NOTE: JST 03:00 - 04:00
    preferred_maintenance_window = "tue:19:00-tue:20:00" # NOTE: JST wed 04:00 - wed 05:00
    apply_immediately            = true
    storage_encrypted            = true
    backup_retention_period      = 14
    deletion_protection          = true
    skip_final_snapshot          = false
  }
}


variable "rds_cluster_instance" {
  type = object({
    engine                     = string
    engine_version             = string
    instance_class             = string
    publicly_accessible        = bool
    auto_minor_version_upgrade = bool
    apply_immediately          = bool
    availability_zones         = list(string)
    backup_retention_period    = number
    min_capacity               = number
    max_capacity               = number
  })

  default = {
    engine                     = "aurora-postgresql"
    engine_version             = "16.2"
    instance_class             = "db.serverless"
    publicly_accessible        = false
    auto_minor_version_upgrade = false
    apply_immediately          = true
    availability_zones         = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
    backup_retention_period    = 7
    min_capacity               = 1
    max_capacity               = 3
  }
}

variable "rds_instances" {
  type = map(object({
    instance_class    = string
    promotion_tier    = number
    availability_zone = string
  }))
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = ["postgresql"]
}

variable "db_ingress_cidr_blocks" {
  type        = list(string)
  default     = [""]
  description = "CIDR block to allow connection to DB server"
}

# ## password
# variable "rds_username" {
#   description = ""
#   type        = string
# }
# 
# variable "rds_password" {
#   description = "RDS のパスワード"
#   type        = string
# }