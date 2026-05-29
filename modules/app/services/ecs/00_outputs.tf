/** 
# OutPuts
*/
output "aws_secretsmanager_secret_api_url_arn" {
  value = aws_secretsmanager_secret.api_url.arn
}

output "aws_secretsmanager_secret_next_public_fullcalendar_license_key_arn" {
  value = aws_secretsmanager_secret.next_public_fullcalendar_license_key.arn
}