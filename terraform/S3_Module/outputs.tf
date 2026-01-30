
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

output "public_access_block" {
  value = {
    block_public_acls   = aws_s3_bucket_public_access_block.s3_bucket_block.block_public_acls
    block_public_policy = aws_s3_bucket_public_access_block.s3_bucket_block.block_public_policy
    ignore_public_acls  = aws_s3_bucket_public_access_block.s3_bucket_block.ignore_public_acls
    restrict_public_buckets = aws_s3_bucket_public_access_block.s3_bucket_block.restrict_public_buckets
  }
}
