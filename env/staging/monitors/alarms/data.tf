data "aws_sns_topic" "notify_slack_test_ao" {
  name = "test-notify-ao-topic"
}

# data "aws_sns_topic" "notify_slack_fatal" {
#   name = "${var.project}-${var.environment}-notify-health-fatal"
# }
# 
# data "aws_sns_topic" "notify_slack_warn" {
#   name = "${var.project}-${var.environment}-notify-health-warn"
# }
# 
# data "aws_sns_topic" "notify_slack_info" {
#   name = "${var.project}-${var.environment}-notify-health-info"
# }
