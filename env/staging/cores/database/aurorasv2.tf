module "cores_database_aurorasv2" {
  source = "../../../../modules/cores/database/aurorasv2"

  common = {
    project     = var.project
    environment = var.environment
  }

  vpc_id        = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.vpc_id
  db_subnet_ids = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_ids

  rds_cluster = {
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
    deletion_protection          = false # NOTE: 検証用として無効化
    skip_final_snapshot          = false
  }

  rds_cluster_instance = {
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

  rds_instances = {
    1 = {
      instance_class    = "db.serverless" #"db.serverless"
      promotion_tier    = 1
      availability_zone = "ap-northeast-1a"
    }
    2 = {
      instance_class    = "db.serverless" #"db.serverless"
      promotion_tier    = 1
      availability_zone = "ap-northeast-1c"
    }
    3 = {
      instance_class    = "db.serverless" #"db.serverless"
      promotion_tier    = 1
      availability_zone = "ap-northeast-1d"
    }
    4 = {
      instance_class    = "db.serverless" #"db.serverless"
      promotion_tier    = 1
      availability_zone = "ap-northeast-1a"
    }
    5 = {
      instance_class    = "db.serverless" #"db.serverless"
      promotion_tier    = 1
      availability_zone = "ap-northeast-1c"
    }
  }

  db_ingress_cidr_blocks = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_cidr
}