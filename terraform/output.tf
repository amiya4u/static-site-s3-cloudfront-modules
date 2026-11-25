output "access_key_id" {
  value = aws_iam_access_key.github_actions.id
}
output "secret_access_key" {
  value = aws_iam_access_key.github_actions.secret
  sensitive = true
}
output "bucket_name" {
  value = module.s3_website.bucket_id
}
output "cloudfront_distribution_id" {
  value = module.cloudfront.cloudfront_distribution_id
}
