
provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_tag" "s3_tags" {
  bucket = aws_s3_bucket.s3_bucket.id
  tags = var.tags
}
