output "arn" {
  value       = aws_s3_bucket.mystate_file.arn
  description = "s3 aws_s3_bucket_arn"
}
output "id" {
  value       = aws_s3_bucket.mystate_file.id
  description = "s3 aws_s3_bucket_id"
}

output "aws_s3_bucket_versioning_id" {
  value       = aws_s3_bucket_versioning.versioning_state.id
  description = "s3 aws_s3_bucket_versioning id"
}

output "aws_s3_bucket_server_side_encryption_configuratio_id" {
  value       = aws_s3_bucket_server_side_encryption_configuration.mystate_file_sse_config.id
  description = "s3 aws_s3_bucket_server_side_encryption_configuration id"
}