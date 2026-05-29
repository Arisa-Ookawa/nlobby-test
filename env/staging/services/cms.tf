# module "services_cms" {
#   source = "../../../modules/services/cms"
# 
#   common = {
#     project     = var.project
#     environment = var.environment
#     region      = var.region
#   }
# 
#   vpc_id = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.vpc_id
# 
#   lb = {
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
#     service_namespace  = "ecs"
#     scalable_dimension = "ecs:service:DesiredCount"
#   }
# 
#   appautoscaling_policy = {
#     scale_in_cooldown  = 300
#     scale_out_cooldown = 10
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
#   }
# 
#   ecr_repository = {
#     image_tag_mutability          = "MUTABLE"
#     force_delete                  = false
#     scan_on_push                  = true
#     lifecycle_policy_count_number = 30
#   }
# 
#   s3_bucket_force_destroy = true # NOTE: 削除保護無効化
# 
#   # repository = ""
# 
#   ecs_cms_to_secrets = ["arn:aws:secretsmanager:ap-northeast-1:133775794121:secret:test-ao-secret-mVOcaU"]
# }