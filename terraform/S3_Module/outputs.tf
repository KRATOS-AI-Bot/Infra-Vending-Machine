
output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "bucket_region" {
  value = aws_s3_bucket.s3_bucket.region
}

output "versioning_status" {
  value = aws_s3_bucket.s3_bucket.versioning.enabled
}

output "public_access_block_status" {
  value = aws_s3_bucket_public_access_block.s3_bucket_public_access_block.block_public_acls
}
