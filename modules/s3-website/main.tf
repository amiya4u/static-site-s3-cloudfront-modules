
#------------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------ 
resource "aws_s3_bucket" "my_bucket_website" {
  bucket = "${var.name_prefix}-bucket"
}
resource "aws_s3_bucket_website_configuration" "example" { # It’s the resource that enables static website hosting on your S3 bucket
  bucket = aws_s3_bucket.my_bucket_website.id

  index_document {
    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }

}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket_website.id
  ignore_public_acls      = false
  block_public_acls       = false
  restrict_public_buckets = false
  block_public_policy     = false
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.my_bucket_website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket_website.arn}/*"
      }
    ]
  })
}
