/** 
# Variables
# NOTE: デフォルト値を使います。
*/
variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "project" {
  type    = string
  default = "test-ao"
}

variable "environment" {
  type    = string
  default = "staging"
}
