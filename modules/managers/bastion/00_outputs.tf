/** 
# OutPuts
*/
output "aws_security_group_bastion" {
  value = aws_security_group.bastion
}

output "aws_instance_bastion" {
  value = aws_instance.bastion
}