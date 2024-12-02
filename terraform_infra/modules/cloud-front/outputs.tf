output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.knowledgecity-dist.arn
}
output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.knowledgecity-dist.domain_name
}