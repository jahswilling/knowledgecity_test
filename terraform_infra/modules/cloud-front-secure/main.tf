data "aws_s3_bucket" "selected_bucket" {
  bucket = var.s3_bucket_id
}

# Create CloudFront Origin Access Control for secure access to S3
resource "aws_cloudfront_origin_access_control" "knowledgecity-s3-oac" {
  name                              = "CloudFront-S3-OAC-${var.s3_bucket_id}"  # Ensuring uniqueness with bucket ID
  description                       = "CloudFront S3 OAC for ${var.s3_bucket_id}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"  # Ensure signed requests for security
}

resource "aws_cloudfront_distribution" "knowledgecity-dist" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = data.aws_s3_bucket.selected_bucket.bucket_regional_domain_name
    origin_id                = var.s3_bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.knowledgecity-s3-oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_bucket_id
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"  # Allow HTTP/HTTPS, no enforced HTTPS redirection
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true  # No custom domain, using CloudFront default cert
  }

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-cloudfront"
  })
}



