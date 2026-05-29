terraform {
  required_version = "~> 1.8"
  backend "s3" {
    bucket = "test-aokawa"
    key    = "global.iam.tfstate"
    region = "ap-northeast-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}
