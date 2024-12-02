resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.bucket_name

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-${var.bucket_name}"
  })
}

# Public access block for S3 bucket
resource "aws_s3_bucket_public_access_block" "secure_bucket_access_block" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Default encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_bucket_encryption" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_arn
    }
  }
}

