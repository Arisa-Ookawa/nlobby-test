module "services_api" {
  source = "../../../modules/services/api"

  common = {
    project     = var.project
    environment = var.environment
    region      = var.region
  }

  vpc_id = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.vpc_id
  #   vpc_lattice_invocation_http_parameters = "dTPQ5SjIIrGOc1PGZYfZpIeMTM+KNkhgIVTGH0yRNfE="
  #   vpc_lattice_resource_configuration_arn = data.terraform_remote_state.staging_cores_network.outputs.cores_network_3az.vpc_lattice_resource_configuration_arn

  lb = {
    drop_invalid_header_fields = false
    enable_deletion_protection = false
    enable_http2               = true
    idle_timeout               = 600
    internal                   = false
    ip_address_type            = "ipv4"
    load_balancer_type         = "application"
    security_groups            = []
    subnet_ids                 = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.public_subnet_ids
    access_logs_enabled        = true
  }

  lb_target_group = {
    deregistration_delay          = 60
    load_balancing_algorithm_type = "round_robin"
    port                          = 80
    protocol                      = "HTTP"
    protocol_version              = "HTTP1"
    slow_start                    = 0
    target_type                   = "ip"
  }

  lb_health_check = {
    enabled             = true
    healthy_threshold   = 2
    interval            = 61
    matcher             = "200"
    path                = "/health"
    port                = 3001
    protocol            = "HTTP"
    timeout             = 60
    unhealthy_threshold = 2
  }

  lb_listener_http = {
    port     = 80
    protocol = "HTTP"
  }

  lb_listener_https = {
    port            = 443
    protocol        = "HTTPS"
    certificate_arn = "arn:aws:acm:ap-northeast-1:133775794121:certificate/f83a23da-d12f-4ee0-90a6-57e504b3947b" # *.dw-ed.com
    ssl_policy      = "ELBSecurityPolicy-2016-08"
    default_action = {
      type = "forward"
    }
  }

  appautoscaling_target = {
    max_capacity       = 10
    min_capacity       = 1
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
  }

  appautoscaling_policy = {
    policy_type            = "TargetTrackingScaling"
    predefined_metric_type = "ECSServiceAverageCPUUtilization"
    statistic              = "Maximum"
    target_value           = 40
    disable_scale_in       = false
    scale_in_cooldown      = 300
    scale_out_cooldown     = 300
  }

  enable_tracking_memory = "1"

  cloudwatch_metric_alarm = {
    scale_out_sns_topic_arns = []
    scale_in_sns_topic_arns  = []
    scale_out_threshold_cpu  = 60
    scale_in_threshold_cpu   = 30
  }

  #   metrics_filter_error = {
  #     pattern   = "ERROR"
  #     namespace = "LogMetricFilter"
  #     value     = "1"
  #     unit      = "None"
  #   }
  # 
  #   metrics_filter_fatal = {
  #     pattern   = "[FATAL]"
  #     namespace = "LogMetricFilter"
  #     value     = "1"
  #     unit      = "None"
  #   }

  ecs_task = {
    cpu    = 2048
    memory = 4096
  }

  ecs_service = {
    desired_count                     = 1
    enable_execute_command            = false
    health_check_grace_period_seconds = 30
    platform_version                  = "1.4.0"
    subnet_ids                        = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.private_subnet_ids
    assign_public_ip                  = false
  }

  ecr_repository = {
    image_tag_mutability          = "MUTABLE"
    force_delete                  = false
    scan_on_push                  = true
    lifecycle_policy_count_number = 30
  }

  s3_bucket_force_destroy = false

  # ingress_nlobby_nat = data.terraform_remote_state.stg_cores_network.outputs.cores_network_3az.nat_gateway
  #   ingress_nlrk_api = [
  #     "52.193.111.233/32", # staging環境
  #   ]
  #   ingress_vpc_lattice = data.terraform_remote_state.staging_cores_network.outputs.cores_network_3az.aws_security_group_vpc_lattice.id
  #   ingress_load_test = [
  #     "18.176.148.107/32",
  #     "52.198.157.76/32"
  #   ]
  #   ingress_gmo_notification = ["210.197.108.196/32"]
  #   ingress_ierae = [
  #     #    "160.16.234.149/32",
  #     #    "49.212.135.68/32",
  #     #    "150.249.212.68/32",
  #     #    "160.16.68.117/32",
  #     #    "150.249.222.160/27",
  #     #    "122.249.156.113/32"
  #   ]

  external_alb_waf_rate_based_ip_limit        = 100
  external_alb_waf_rate_based_ip_limit_action = "block"

  repository = "dwango-education/nlobby"

  #   rule_oauth_token = {
  #     state               = "ENABLED"
  #     schedule_expression = "cron(0 16 * * ? *)" #JST Every day 01:00
  #     force_destroy       = true
  #   }
  # 
  #   rule_push_notify = {
  #     state               = "ENABLED"
  #     schedule_expression = "cron(* * * * ? *)" #JST Every minute
  #     force_destroy       = true
  #   }
  # 
  #   rule_form_status = {
  #     state               = "ENABLED"
  #     schedule_expression = "cron(0 15 * * ? *)" #JST Every day 00:00
  #     force_destroy       = true
  #   }
  # 
  #   rule_user_get = {
  #     state               = "ENABLED"
  #     schedule_expression = "cron(0 19 * * ? *)" #JST Every day 04:00
  #     force_destroy       = true
  #   }
  # 
  #   rule_request_retry = {
  #     state               = "ENABLED"
  #     schedule_expression = "cron(*/10 * * * ? *)" #JST Every 10 minite
  #     force_destroy       = true
  #   }
  # 
  #   rule_cancel_retry = {
  #     state               = "ENABLED"
  #     schedule_expression = "cron(*/10 * * * ? *)" #JST Every 10 minite
  #     force_destroy       = true
  #   }
  # 
  #   batch_event_token_update = {
  #     invocation_endpoint              = "https://rk-api.nlobby.stg.dw-fr.com/batch/auth/update-system-token"
  #     http_method                      = "POST"
  #     invocation_rate_limit_per_second = 300
  #   }
  # 
  #   batch_event_push_notify = {
  #     invocation_endpoint              = "https://rk-api.nlobby.stg.dw-fr.com/batch/notification/send"
  #     http_method                      = "POST"
  #     invocation_rate_limit_per_second = 300
  #   }
  # 
  #   batch_event_form_update = {
  #     invocation_endpoint              = "https://rk-api.nlobby.stg.dw-fr.com/batch/form/sync-publication-status"
  #     http_method                      = "POST"
  #     invocation_rate_limit_per_second = 300
  #   }
  # 
  #   batch_event_user_get = {
  #     invocation_endpoint              = "https://rk-api.nlobby.stg.dw-fr.com/batch/user/sync-kms"
  #     http_method                      = "POST"
  #     invocation_rate_limit_per_second = 300
  #   }
  # 
  #   batch_event_requesyt_retry = {
  #     invocation_endpoint              = "https://rk-api.nlobby.stg.dw-fr.com/batch/plus-one/retry-ticket-consumption"
  #     http_method                      = "POST"
  #     invocation_rate_limit_per_second = 300
  #   }
  # 
  #   batch_event_cancel_retry = {
  #     invocation_endpoint              = "https://rk-api.nlobby.stg.dw-fr.com/batch/plus-one/retry-ticket-cancellation"
  #     http_method                      = "POST"
  #     invocation_rate_limit_per_second = 300
  #   }
}