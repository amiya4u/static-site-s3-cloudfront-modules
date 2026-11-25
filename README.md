This is the README file
# Day X - S3 + CloudFront + GitHub Actions CI/CD with modules 

## What I built
A static website hosted in an S3 bucket configured for static website hosting. CloudFront serves the site over HTTPS with caching and a custom domain.GitHub Actions automates deployment: on push to main, it syncs the site files to S3 and creates a CloudFront invalidation.

## Concepts I learned
Configuring S3 bucket policy for public access via terraform. 
Handling CloudFront cache invalidation on deployment

## Terraform resources used
aws_cloudfront_distribution.website
aws_s3_bucket.my_bucket_website
aws_s3_bucket_website_configuration.example
aws_s3_bucket_public_access_block.public_access
aws_s3_bucket_policy.policy
aws_iam_user.github_actions
ws_iam_access_key.github_actions

## IAM - what I understood
Bucket policy uses Principal: "*" because it controls who can access the S3 bucket from outside (public read). IAM user policy has no Principal — it’s attached to the GitHub Actions user and gives it rights to upload/delete files and invalidate CloudFront.

## GitHub Actions - how it works
Push to main → GitHub runs the workflow → configures AWS credentials using secrets → runs aws s3 sync to upload files → runs aws cloudfront create-invalidation to clear cache so visitors see the new version.

## Errors I hit and how I fixed them
Signature error: AWS_SECRET_ACCESS_KEY in GitHub Secrets had wrong value. Fixed by running terraform output -raw secret_access_key and updating the secret fresh.
Git push failed: PAT had expired. Fixed by generating new PAT on GitHub and updating remote URL.

## Commands I used today
- Too list CloudFront domain name
aws cloudfront list-distributions --query "DistributionList.Items[0].DomainName" --output text

- To delete files from AWS bucket 
aws s3 rm s3://amiya-nov-2026-bucket --recursive

- Shows all resources currently tracked in Terraform state
terraform state list

terraform output 
terraform output -raw secret_access_key

PAT expired, so created new PAT and added it: 
git remote set-url origin https://amiya4u:ghp_token@github.com/amiya4u/static-site-s3-cloudfront.git


## What I want to revisit
Handling CloudFront cache invalidation on deployment
