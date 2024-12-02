# Create KMS Key for Video File Encryption
resource "aws_kms_key" "s3_video_kms" {
    description             = "KMS Key for Video File Encryption"
    enable_key_rotation     = true
    deletion_window_in_days = 30  # Optional: Set the number of days to retain the key before deletion

    tags = {
        Name = "S3-Video-Encryption"
    }
}

# A separate secure bucket and CloudFront for videos
module "s3_videos" {
    source        = "./modules/s3-static-secure"
    bucket_name   = var.video_bucket_name
    kms_key_arn   = aws_kms_key.s3_video_kms.arn  # Use the created KMS key ARN for encryption
    common_tags   = local.common_tags
    naming_prefix = local.naming_prefix
}

module "cloud_front_videos" {
    source                = "./modules/cloud-front-secure"
    s3_bucket_id          = module.s3_videos.bucket_id
    kms_key_arn           = aws_kms_key.s3_video_kms.arn  # Ensure KMS encryption for video delivery
    common_tags           = local.common_tags
    naming_prefix         = local.naming_prefix
}

module "s3_cf_policy_videos" {
    source                        = "./modules/s3-cf-policy"
    bucket_id                     = module.s3_videos.bucket_id
    bucket_arn                    = module.s3_videos.bucket_arn
    cloudfront_distribution_arn   = module.cloud_front_videos.cloudfront_distribution_arn
}

# Output the KMS Key ARN for reference
output "kms_key_arn" {
    value = aws_kms_key.s3_video_kms.arn
}

