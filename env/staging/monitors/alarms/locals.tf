# locals {
#   rds_alarms = [
#     {
#       rds_name = [
#         "nlobby-test-ao-staging-aurora-sv2-1",
#         "nlobby-test-ao-staging-aurora-sv2-2",
#         "nlobby-test-ao-staging-aurora-sv2-3"
#       ]
#     }
#   ]
#   rds_alarms_name = flatten([for v in local.rds_alarms : v.name]
#   )
# }