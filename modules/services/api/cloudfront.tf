# resource "aws_cloudfront_origin_access_control" "oac" {
#   name                              = "${var.common.project}-${var.common.environment}-oac"
#   description                       = "OAC for CloudFront access"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }
# 
# resource "aws_cloudfront_origin_access_identity" "maintenance_assets" {
#   comment = "s3 maintenance_assets distribution"
# }
# 
# resource "aws_cloudfront_distribution" "maintenance_assets" {
#   comment             = "nlobby-staging-test-ao-distribution"
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_All"
#   retain_on_delete    = false
#   wait_for_deployment = false
#   default_root_object = "index.html"
#   http_version        = "http2"
#   aliases             = ["nlobby-stg.dw-ed.com"]
#   #web_acl_id          = aws_wafv2_web_acl.external.arn
# 
#   custom_error_response {
#     error_caching_min_ttl = "300"
#     error_code            = "503"
#     response_code         = "503"
#     response_page_path    = "/maintenance_template.html"
#   }
# 
#   origin {
#     domain_name = aws_s3_bucket.maintenance_assets.bucket_regional_domain_name
#     origin_id   = aws_s3_bucket.maintenance_assets.id
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.maintenance_assets.cloudfront_access_identity_path
#     }
#   }
# 
#   default_cache_behavior {
#     target_origin_id       = aws_s3_bucket.maintenance_assets.id
#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#     allowed_methods        = ["GET", "HEAD", "OPTIONS"]
#     cached_methods         = ["GET", "HEAD"]
#     compress               = true
#     forwarded_values {
#       query_string = true
#       cookies {
#         forward = "none"
#       }
#     }
#   }
# 
#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }
# 
#   viewer_certificate {
#     cloudfront_default_certificate = "false"
#     acm_certificate_arn            = "arn:aws:acm:us-east-1:133775794121:certificate/9dc3d25b-7435-4b5d-9647-200073dc5a42" # *.dw-ed.com
#     minimum_protocol_version       = "TLSv1.2_2021"
#     ssl_support_method             = "sni-only"
#   }
# }
