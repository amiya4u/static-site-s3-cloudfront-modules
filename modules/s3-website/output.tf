output "bucket_id" {
  value = aws_s3_bucket.my_bucket_website.id
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket_website.arn
}
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}
