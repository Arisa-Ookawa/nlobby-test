/**
# Event Bridge (Rule)
*/
# # OAuthトークン更新バッチ
# resource "aws_cloudwatch_event_rule" "rule_oauth_token" {
#   name                = "${var.common.project}-${var.common.environment}-auth-batch-rule-${var.sfx}"
#   description         = "${var.common.project}-${var.common.environment}-auth-batch-rule-${var.sfx}"
#   schedule_expression = var.rule_oauth_token.schedule_expression
#   force_destroy       = var.rule_oauth_token.force_destroy
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-auth-batch-rule-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# # Push通知バッチ
# resource "aws_cloudwatch_event_rule" "rule_push_notify" {
#   name                = "${var.common.project}-${var.common.environment}-push-notify-rule-${var.sfx}"
#   description         = "${var.common.project}-${var.common.environment}-push-notify-rule-${var.sfx}"
#   schedule_expression = var.rule_push_notify.schedule_expression
#   force_destroy       = var.rule_push_notify.force_destroy
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-push-notify-rule-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# # フォームステータス更新バッチ
# resource "aws_cloudwatch_event_rule" "rule_form_status" {
#   name                = "${var.common.project}-${var.common.environment}-form-status-rule-${var.sfx}"
#   description         = "${var.common.project}-${var.common.environment}-form-status-rule-${var.sfx}"
#   schedule_expression = var.rule_form_status.schedule_expression
#   force_destroy       = var.rule_form_status.force_destroy
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-form-status-rule-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# # ユーザー情報取得バッチ
# resource "aws_cloudwatch_event_rule" "rule_user_get" {
#   name                = "${var.common.project}-${var.common.environment}-user-get-rule-${var.sfx}"
#   description         = "${var.common.project}-${var.common.environment}-user-get-rule-${var.sfx}"
#   schedule_expression = var.rule_user_get.schedule_expression
#   force_destroy       = var.rule_user_get.force_destroy
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-user-get-rule-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }

# resource "aws_cloudwatch_event_rule" "rule_request_retry" {
#   name                = "${var.common.project}-${var.common.environment}-request-retry-rule-${var.sfx}"
#   description         = "${var.common.project}-${var.common.environment}-request-retry-rule-${var.sfx}"
#   state               = var.rule_request_retry.state
#   schedule_expression = var.rule_request_retry.schedule_expression
#   force_destroy       = var.rule_request_retry.force_destroy
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-request-retry-rule-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }

# /**
# # Event Bridge (Target)
# */
# resource "aws_cloudwatch_event_target" "oauth_target" {
#   arn      = aws_cloudwatch_event_api_destination.batch_event_token_update.arn
#   rule     = aws_cloudwatch_event_rule.rule_oauth_token.id
#   role_arn = aws_iam_role.event_bridge_api.arn
# }
# 
# resource "aws_cloudwatch_event_target" "push_notify" {
#   arn      = aws_cloudwatch_event_api_destination.batch_event_push_notify.arn
#   rule     = aws_cloudwatch_event_rule.rule_push_notify.id
#   role_arn = aws_iam_role.event_bridge_api.arn
# }
# 
# resource "aws_cloudwatch_event_target" "form_target" {
#   arn      = aws_cloudwatch_event_api_destination.batch_event_form_update.arn
#   rule     = aws_cloudwatch_event_rule.rule_form_status.id
#   role_arn = aws_iam_role.event_bridge_api.arn
# }
# 
# resource "aws_cloudwatch_event_target" "user_target" {
#   arn      = aws_cloudwatch_event_api_destination.batch_event_user_get.arn
#   rule     = aws_cloudwatch_event_rule.rule_user_get.id
#   role_arn = aws_iam_role.event_bridge_api.arn
# }

# /**
# # Event Bridge (APIの送信先)
# */
# resource "aws_cloudwatch_event_api_destination" "batch_event_token_update" {
#   name                             = "${var.common.project}-${var.common.environment}-token-update-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-token-update-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_token_update.invocation_endpoint
#   http_method                      = var.batch_event_token_update.http_method
#   invocation_rate_limit_per_second = var.batch_event_token_update.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }
# 
# resource "aws_cloudwatch_event_api_destination" "batch_event_push_notify" {
#   name                             = "${var.common.project}-${var.common.environment}-push-notify-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-push-notify-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_push_notify.invocation_endpoint
#   http_method                      = var.batch_event_push_notify.http_method
#   invocation_rate_limit_per_second = var.batch_event_push_notify.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }
# 
# resource "aws_cloudwatch_event_api_destination" "batch_event_form_update" {
#   name                             = "${var.common.project}-${var.common.environment}-form-update-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-form-update-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_form_update.invocation_endpoint
#   http_method                      = var.batch_event_form_update.http_method
#   invocation_rate_limit_per_second = var.batch_event_form_update.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }
# 
# resource "aws_cloudwatch_event_api_destination" "batch_event_user_get" {
#   name                             = "${var.common.project}-${var.common.environment}-get-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-get-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_user_get.invocation_endpoint
#   http_method                      = var.batch_event_user_get.http_method
#   invocation_rate_limit_per_second = var.batch_event_user_get.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }

# /**
# # Event Bridge (APIの送信先)
# */
# resource "aws_cloudwatch_event_api_destination" "batch_event_token_update" {
#   name                             = "${var.common.project}-${var.common.environment}-token-update-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-token-update-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_token_update.invocation_endpoint
#   http_method                      = var.batch_event_token_update.http_method
#   invocation_rate_limit_per_second = var.batch_event_token_update.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }
# 
# resource "aws_cloudwatch_event_api_destination" "batch_event_push_notify" {
#   name                             = "${var.common.project}-${var.common.environment}-push-notify-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-push-notify-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_push_notify.invocation_endpoint
#   http_method                      = var.batch_event_push_notify.http_method
#   invocation_rate_limit_per_second = var.batch_event_push_notify.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }
# 
# resource "aws_cloudwatch_event_api_destination" "batch_event_form_update" {
#   name                             = "${var.common.project}-${var.common.environment}-form-update-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-form-update-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_form_update.invocation_endpoint
#   http_method                      = var.batch_event_form_update.http_method
#   invocation_rate_limit_per_second = var.batch_event_form_update.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }
# 
# resource "aws_cloudwatch_event_api_destination" "batch_event_user_get" {
#   name                             = "${var.common.project}-${var.common.environment}-get-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-get-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_user_get.invocation_endpoint
#   http_method                      = var.batch_event_user_get.http_method
#   invocation_rate_limit_per_second = var.batch_event_user_get.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }

# resource "aws_cloudwatch_event_api_destination" "batch_event_request_retry" {
#   name                             = "${var.common.project}-${var.common.environment}-get-batch-${var.sfx}"
#   description                      = "${var.common.project}-${var.common.environment}-get-batch-${var.sfx}"
#   invocation_endpoint              = var.batch_event_request_retry.invocation_endpoint
#   http_method                      = var.batch_event_request_retry.http_method
#   invocation_rate_limit_per_second = var.batch_event_request_retry.invocation_rate_limit_per_second
#   connection_arn                   = aws_cloudwatch_event_connection.connection.arn
# }

# /**
# # Event Bridge (connection)
# */
# resource "aws_cloudwatch_event_connection" "connection" {
#   name               = "${var.common.project}-${var.common.environment}-api-connection-${var.sfx}"
#   description        = "${var.common.project}-${var.common.environment}-api-connection-${var.sfx}"
#   authorization_type = "BASIC"
#   auth_parameters {
#     basic {
#       username = "test"
#       password = "dummy"
#     }
#     invocation_http_parameters {
#       header {
#         key   = "x-nlobby-batch-token"
#         value = "dTPQ5SjIIrGOc1PGZYfZpIeMTM+KNkhgIVTGH0yRNfE="
#       }
#     }
#   }
# }