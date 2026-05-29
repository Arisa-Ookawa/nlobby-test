module "cores_storage_s3" {
  source = "../../../../modules/cores/storage/s3"

  common = {
    project     = var.project
    environment = var.environment
  }

  s3_bucket_force_destroy = true
}