# module "services_frontend" {
#   source = "../../../modules/services/frontend"
# 
#   common = {
#     project     = var.project
#     environment = var.environment
#     region      = var.region
#   }
# 
#   vpc_id = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.vpc_id
#   # vpc_lattice_arn = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.vpc_lattice_resource_configuration
# 
#   lb = {
#     drop_invalid_header_fields = false
#     enable_deletion_protection = false
#     enable_http2               = true
#     idle_timeout               = 600
#     internal                   = false
#     ip_address_type            = "ipv4"
#     load_balancer_type         = "application"
#     enable_waf_fail_open       = false ## 追加したもの
#     security_groups            = []
#     subnet_ids                 = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.public_subnet_ids
#     access_logs_enabled        = true
#     connection_logs_enabled    = true
#   }
# 
#   internal_lb = {
#     drop_invalid_header_fields = false
#     enable_deletion_protection = false
#     enable_http2               = true
#     idle_timeout               = 600
#     internal                   = true
#     ip_address_type            = "ipv4"
#     load_balancer_type         = "application"
#     security_groups            = []
#     subnet_ids                 = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_ids
#     access_logs_enabled        = true
#     connection_logs_enabled    = true
#   }
# 
#   maint_lb = {
#     drop_invalid_header_fields = false
#     enable_deletion_protection = false
#     enable_http2               = true
#     idle_timeout               = 600
#     internal                   = false
#     ip_address_type            = "ipv4"
#     load_balancer_type         = "application"
#     security_groups            = []
#     subnet_ids                 = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.public_subnet_ids
#     access_logs_enabled        = true
#     connection_logs_enabled    = true
#   }
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
#   maint_lb_target_group = {
#     deregistration_delay          = 60
#     load_balancing_algorithm_type = "round_robin"
#     port                          = 80
#     protocol                      = "HTTP"
#     protocol_version              = "HTTP1"
#     slow_start                    = 0
#     target_type                   = "lambda"
#   }
# 
#   lb_target_group_ws = module.services_ws.aws_lb_target_group.arn
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
#   lb_listener_http = {
#     port     = 80
#     protocol = "HTTP"
#   }
# 
#   lb_listener_https = {
#     port            = 443
#     protocol        = "HTTPS"
#     certificate_arn = "arn:aws:acm:ap-northeast-1:133775794121:certificate/f83a23da-d12f-4ee0-90a6-57e504b3947b" # *.dw-ed.com
#     ssl_policy      = "ELBSecurityPolicy-2016-08"
#     default_action = {
#       type = "forward"
#     }
#   }
# 
#   appautoscaling_target = {
#     max_capacity       = 2
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
#     scale_out_cooldown     = 10
#   }
# 
#   cloudwatch_metric_alarm = {
#     scale_out_sns_topic_arns = []
#     scale_in_sns_topic_arns  = []
#     scale_out_threshold_cpu  = 60
#     scale_in_threshold_cpu   = 30
#   }
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
#     subnet_ids                        = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_ids
#     assign_public_ip                  = false
#     platform_version                  = "LATEST"
#   }
# 
#   ecr_repository = {
#     image_tag_mutability          = "MUTABLE"
#     force_delete                  = false
#     scan_on_push                  = true
#     lifecycle_policy_count_number = 30
#   }
# 
#   domain_name             = "nlobby-stg.dw-ed.com"
#   s3_bucket_force_destroy = true # NOTE: 削除保護無効化
# 
#   # ingress_nlobby_nat = [data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.nat_gateway.public_ip]
#   # repository = ""
# 
#   #   enable_waf                                  = "1"
#   #   whitelist_ip                                = ["106.72.216.33/32"] # my IP
#   #   maintenance_whitelist_ip                    = ["106.72.216.33/32"] # my IP
#   #   external_alb_waf_rate_based_ip_limit        = 100
#   #   external_alb_waf_rate_based_ip_limit_action = "block"
#   #is_maintenance                              = "REGIONAL"
# 
#   ecs_frontend_to_secrets = ["arn:aws:secretsmanager:ap-northeast-1:133775794121:secret:test-ao-secret-mVOcaU"]
# }