# module "services_ws" {
#   source = "../../../modules/services/ws"
# 
#   common = {
#     project     = var.project
#     environment = var.environment
#     region      = var.region
#   }
# 
#   vpc_id = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.vpc_id
# 
#   lb_target_group = {
#     deregistration_delay          = 60
#     load_balancing_algorithm_type = "round_robin"
#     port                          = 80
#     protocol                      = "HTTP"
#     protocol_version              = "HTTP1"
#     slow_start                    = 0
#     target_type                   = "ip"
#   }
# 
#   lb_health_check = {
#     enabled             = true
#     healthy_threshold   = 2
#     interval            = 61
#     matcher             = "200"
#     path                = "/health"
#     port                = 3001
#     protocol            = "HTTP"
#     timeout             = 60
#     unhealthy_threshold = 2
#   }
# 
#   appautoscaling_target = {
#     max_capacity       = 10
#     min_capacity       = 1
#     scalable_dimension = "ecs:service:DesiredCount"
#     service_namespace  = "ecs"
#   }
# 
#   appautoscaling_policy = {
#     policy_type            = "TargetTrackingScaling"
#     predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     statistic              = "Maximum"
#     target_value           = 40
#     disable_scale_in       = false
#     scale_in_cooldown      = 300
#     scale_out_cooldown     = 300
#   }
# 
#   enable_tracking_memory = "1"
# 
#   cloudwatch_metric_alarm = {
#     scale_out_sns_topic_arns = []
#     scale_in_sns_topic_arns  = []
#     scale_out_threshold_cpu  = 60
#     scale_in_threshold_cpu   = 30
#   }
# 
#   #   metrics_filter_error = {
#   #     pattern   = "ERROR"
#   #     namespace = "LogMetricFilter"
#   #     value     = "1"
#   #     unit      = "None"
#   #   }
#   # 
#   #   metrics_filter_fatal = {
#   #     pattern   = "[FATAL]"
#   #     namespace = "LogMetricFilter"
#   #     value     = "1"
#   #     unit      = "None"
#   #   }
# 
#   ecs_task = {
#     cpu    = 1024
#     memory = 4096
#   }
# 
#   ecs_service = {
#     desired_count                     = 1
#     enable_execute_command            = false
#     health_check_grace_period_seconds = 30
#     platform_version                  = "1.4.0"
#     subnet_ids                        = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_ids
#     assign_public_ip                  = false
#   }
# 
#   ecr_repository = {
#     image_tag_mutability          = "MUTABLE"
#     force_delete                  = false
#     scan_on_push                  = true
#     lifecycle_policy_count_number = 30
#   }
# 
#   frontend_security_group = "sg-0ff98b1be7a48f02a"
# 
#   #   ingress_nlobby_nat = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.nat_gateway
# 
#   #   external_alb_waf_rate_based_ip_limit        = 100
#   #   external_alb_waf_rate_based_ip_limit_action = "block"
# 
#   repository = "dwango-education/nlobby"
# 
#   elasticache_subnet_group = {
#     subnet_ids = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_ids
#   }
# 
#   replication_group_id       = "test-ao-staging-ws"
#   description                = "valkey for test-ao-staging-ws"
#   engine                     = "valkey"
#   engine_version             = "8.1"
#   node_type                  = "cache.t4g.micro"
#   subnet_group_name          = "test-ao-staging-ws-subnet-group-01"
#   parameter_group_name       = "default.valkey8"
#   num_cache_clusters         = 1
#   multi_az_enabled           = false
#   automatic_failover_enabled = false
#   maintenance_window         = "fri:07:00-fri:08:00" # JST 金曜 15:00 - 16:00
#   snapshot_retention_limit   = 0
#   apply_immediately          = true
#   auto_minor_version_upgrade = true
# 
# }