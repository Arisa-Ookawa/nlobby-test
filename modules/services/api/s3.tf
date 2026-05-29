/** 
# S3 ( ALB Log )
*/
data "aws_elb_service_account" "self" {}

resource "aws_s3_bucket" "alb_api_log" {
  bucket        = "${var.common.project}-${var.common.environment}-api-alb-log-s3-bucket-${var.sfx}"
  force_destroy = var.s3_bucket_force_destroy

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-api-alb-log-s3-bucket-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "alb_api_log" {
  bucket = aws_s3_bucket.alb_api_log.id
  versioning_configuration {
    status = var.versioning_configuration
  }
}

resource "aws_s3_bucket_public_access_block" "alb_api_log" {
  bucket = aws_s3_bucket.alb_api_log.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "alb_api_log_to_s3" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.alb_api_log.arn}/AWSLogs/${data.aws_caller_identity.self.account_id}/*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.self.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "alb_api_log" {
  bucket = aws_s3_bucket.alb_api_log.id
  policy = data.aws_iam_policy_document.alb_api_log_to_s3.json
}

resource "aws_s3_bucket" "maintenance_assets" {
  bucket        = "${var.common.project}-${var.common.environment}-maintenance-assets-s3-bucket-${var.sfx}"
  force_destroy = var.s3_bucket_force_destroy

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-maintenance-assets-s3-bucket-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}
