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