/** 
# Remote State
*/
data "terraform_remote_state" "stg_cores_network" {
  backend = "s3"
  config = {
    bucket = "test-aokawa"
    key    = "stg.cores.network.tfstate"
    region = "ap-northeast-1"
  }
}

# data "terraform_remote_state" "services_cms" {
#   backend = "s3"
#   config = {
#     bucket = "test-aokawa"
#     key    = "staging.services.tfstate"
#     region = "ap-northeast-1"
#   }
# }