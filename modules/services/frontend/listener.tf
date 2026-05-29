/** 
# Listener
*/
resource "aws_lb_listener" "http" {
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

resource "aws_lb_listener" "https" {
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

/** 
# Listener Rule for Valky
*/
resource "aws_lb_listener_rule" "ws" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = var.lb_target_group_ws
  }

  condition {
    path_pattern {
      values = ["/ws/*"]
    }
  }

  tags = {
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}
