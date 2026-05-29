module "ip_address_list" {
  source = "git::https://github.com/Arisa-Ookawa/ip-controller.git//terraform?ref=v2.1.0"
}

locals {
  ip_address_list_twingate      = "35.72.49.205/32" # twingate
  image_url                     = "https://s3://nlobby-test-ao-staging-maintenance-assets-s3-bucket-01/logo.png"
  maintenance_template_contents = "https://nlobby-test-ao-staging-maintenance-assets-s3-bucket-01.s3.ap-northeast-1.amazonaws.com/logo.png"
  #  image_url                = "https://${aws_s3_bucket.maintenance_assets.bucket_domain_name}/logo.png"
}