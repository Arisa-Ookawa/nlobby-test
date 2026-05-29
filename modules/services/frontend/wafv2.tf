# /** 
# # WAF ( IP sets )
# */
# resource "aws_wafv2_ip_set" "this" {
#   name               = "${var.common.project}-${var.common.environment}-whitelist-waf-ipset${var.sfx}"
#   description        = "${var.common.project}-${var.common.environment}-whitelist-waf-ipset${var.sfx}"
#   scope              = "REGIONAL"
#   ip_address_version = "IPV4"
#   addresses          = var.whitelist_ip
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-whitelist-waf-ipset${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# resource "aws_wafv2_ip_set" "maintenance" {
#   name               = "${var.common.project}-${var.common.environment}-maintenance-whitelist-waf-ipset${var.sfx}"
#   description        = "${var.common.project}-${var.common.environment}-maintenance-whitelist-waf-ipset${var.sfx}"
#   scope              = "REGIONAL"
#   ip_address_version = "IPV4"
#   addresses          = var.maintenance_whitelist_ip
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-maintenance-whitelist-waf-ipset${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# /** 
# # WAF ( ACL )
# */
# resource "aws_wafv2_web_acl" "frontend_external" {
#   name  = "${var.common.project}-${var.common.environment}-frontend-external-${var.sfx}"
#   scope = "REGIONAL"
# 
#   dynamic "default_action" {
#     for_each = var.external_alb_waf_default_action == "block" ? toset([var.external_alb_waf_default_action]) : []
#     content {
#       block {}
#     }
#   }
#   dynamic "default_action" {
#     for_each = var.external_alb_waf_default_action == "allow" ? toset([var.external_alb_waf_default_action]) : []
#     content {
#       allow {}
#     }
#   }
# 
#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "${var.common.project}-${var.common.environment}-frontend-external-${var.sfx}"
#     sampled_requests_enabled   = true
#   }
# 
#   # Rule 0: エラーページを表示
#   rule {
#     name     = "allow-access-during-maintenance"
#     priority = 0
# 
#     statement {
#       not_statement {
#         statement {
#           ip_set_reference_statement {
#             arn = aws_wafv2_ip_set.maintenance.arn
#           }
#         }
#       }
#     }
# 
#     action {
#       dynamic "count" {
#         for_each = var.enable_maintenance_mode ? [] : [1]
#         content {}
#       }
# 
#       dynamic "block" {
#         for_each = var.enable_maintenance_mode ? [1] : []
#         content {
#           custom_response {
#             custom_response_body_key = "maintenance"
#             response_code            = var.common.environment == "production" ? 503 : 200
#           }
#         }
#       }
#     }
# 
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "maintenance"
#       sampled_requests_enabled   = true
#     }
#   }
# 
#   # Rule 1: IPsetからのアクセスを許可
#   rule {
#     name     = "allow-whitelist-ipset"
#     priority = 1
# 
#     statement {
#       ip_set_reference_statement {
#         arn = aws_wafv2_ip_set.this.arn
#       }
#     }
#     action {
#       allow {}
#     }
# 
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "allow-whitelist-ipset"
#       sampled_requests_enabled   = true
#     }
#   }
# 
#   # Rule 2: rate limit
#   rule {
#     name     = "rate-based-rule"
#     priority = 2
# 
#     dynamic "action" {
#       for_each = var.external_alb_waf_rate_based_ip_limit_action == "block" ? toset([var.external_alb_waf_rate_based_ip_limit_action]) : []
#       content {
#         block {
#           custom_response {
#             custom_response_body_key = "rate-exceeded"
#             response_code            = 403
#           }
#         }
#       }
#     }
#     dynamic "action" {
#       for_each = var.external_alb_waf_rate_based_ip_limit_action == "count" ? toset([var.external_alb_waf_rate_based_ip_limit_action]) : []
#       content {
#         count {}
#       }
#     }
# 
#     statement {
#       rate_based_statement {
#         aggregate_key_type = "IP"
#         limit              = var.external_alb_waf_rate_based_ip_limit
#       }
#     }
# 
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "rate-based-rule-metric"
#       sampled_requests_enabled   = true
#     }
#   }
# 
#   custom_response_body {
#     key          = "maintenance"
#     content_type = "TEXT_HTML"
#     content      = data.aws_s3_object.maintenance_html.body
#   }
# 
#   custom_response_body {
#     key          = "path-blocked"
#     content_type = "TEXT_PLAIN"
#     content      = "403 Invalid Path"
#   }
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-frontend-external-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# resource "aws_wafv2_web_acl_association" "frontend_external" {
#   resource_arn = aws_lb.this.arn
#   web_acl_arn  = aws_wafv2_web_acl.frontend_external.arn
# }