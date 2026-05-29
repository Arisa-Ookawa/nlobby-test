/** 
# S3 ( nlobby-test-ao )
*/
resource "aws_s3_bucket" "nlobby_test_ao_file" {
  bucket        = "${var.common.project}-test-ao-file-${var.common.environment}"
  force_destroy = var.s3_bucket_force_destroy

  tags = {
    Name        = "${var.common.project}-test-ao-file-${var.common.environment}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "aws_s3_bucket_nlobby_test_ao_file" {
  bucket = aws_s3_bucket.nlobby_test_ao_file.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "nlobby_test_ao_file" {
  bucket = aws_s3_bucket.nlobby_test_ao_file.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "versioning_nlobby_test_ao_file" {
  bucket = aws_s3_bucket.nlobby_test_ao_file.id
  versioning_configuration {
    status = "Disabled"
  }
}