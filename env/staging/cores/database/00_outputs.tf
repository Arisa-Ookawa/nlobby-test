/** 
# Outputs
*/
output "cores_database_aurorasv2_aws_rds_cluster_this_endpoint" {
  value = module.cores_database_aurorasv2.aws_rds_cluster_this.endpoint
}

output "cores_database_aurorasv2_aws_rds_cluster_this_reader_endpoint" {
  value = module.cores_database_aurorasv2.aws_rds_cluster_this.reader_endpoint
}