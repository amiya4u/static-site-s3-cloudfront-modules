provider "aws" {
  region = var.region
}
module "s3_website" {
  source = "../modules/s3-website"
  name_prefix = var.name_prefix
}
module "cloudfront" {
  source = "../modules/cloudfront"
  website_endpoint = module.s3_website.website_endpoint
}


#------------------------------------------------------------------------------
# IAM User for GitHub Actions
#------------------------------------------------------------------------------
resource "aws_iam_user" "github_actions" {
  name = "${var.name_prefix}-github-actions"
}

resource "aws_iam_access_key" "github_actions" {
  user = aws_iam_user.github_actions.name
}

#------------------------------------------------------------------------------
# Policy for IAM User created for GitHub Actions
#------------------------------------------------------------------------------
resource "aws_iam_user_policy" "github_actions" {
  user = aws_iam_user.github_actions.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = ["s3:GetObject","s3:PutObject","s3:DeleteObject"]
        Resource  = "${module.s3_website.bucket_arn}/*"
      },
      {
        Effect   = "Allow"
        Action   = "s3:ListBucket"
        Resource = module.s3_website.bucket_arn
       },       
      {
        Effect = "Allow"
        Action = "cloudfront:CreateInvalidation"
        Resource = "*"
      }
    ]
  })
}
