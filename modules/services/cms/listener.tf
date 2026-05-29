/** 
# Listener
*/
resource "aws_lb_listener" "http_cms" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_http.port
  protocol          = var.lb_listener_http.protocol

  default_action {
    order = 1
    type  = "redirect"

    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_cms" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_https.port
  protocol          = var.lb_listener_https.protocol
  ssl_policy        = var.lb_listener_https.ssl_policy
  certificate_arn   = var.lb_listener_https.certificate_arn

  default_action {
    order            = 1
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# /** 
# # Listener Rule
# */
# # NOTE: https://github.com/dwango-zane/zane_infra_config_mgmt/blob/master/n-dwschool/lb/modules/listener_rule.tf#L1-L2
# resource "aws_lb_listener_rule" "ignore_some_trailing_slashes" {
#   listener_arn = aws_lb_listener.https.arn
#   priority     = 2
# 
#   action {
#     type = "redirect"
# 
#     redirect {
#       host        = "#{host}"
#       path        = "/admin/"
#       port        = "443"
#       protocol    = "HTTPS"
#       query       = "#{query}"
#       status_code = "HTTP_301"
#     }
#   }
# 
#   condition {
#     path_pattern {
#       values = [
#         "/admin",
#       ]
#     }
#   }
# 
#   tags = {
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# resource "aws_lb_listener_rule" "nlobby_cms" {
#   listener_arn = aws_lb_listener.https.arn
#   priority     = 1
# 
#   action {
#     target_group_arn = aws_lb_target_group.this.arn
#     type             = "forward"
#   }
# 
#   condition {
#     path_pattern {
#       values = [
#         "/", # NOTE: 
#       ]
#     }
#   }
# 
#   tags = {
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }