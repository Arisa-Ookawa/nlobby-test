/**
# Variables for COMMON
*/
variable "common" {
  type = object({
    project     = string
    environment = string
  })

  default = {
    project     = ""
    environment = ""
  }
}

/** 
# Variables for S3
*/
variable "s3_bucket_force_destroy" {
  type    = bool
  default = false
}

variable "allowed_origins_nlobby_test_ao_file" {
  type    = list(string)
  default = [""]
}