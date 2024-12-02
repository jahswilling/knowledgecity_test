# Loop through the websites and create S3, CloudFront, and Policies
module "s3_website" {
    for_each      = toset(var.website_buckets)
    source        = "./modules/s3-static-website"
    bucket_name   = each.key
    source_files  = "webfiles" # Adjust if each has its folder
    common_tags   = local.common_tags
    naming_prefix = local.naming_prefix
}

module "cloud_front" {
    for_each                 = module.s3_website
    source                   = "./modules/cloud-front"
    s3_bucket_id             = each.value.static_website_id
    common_tags              = local.common_tags
    naming_prefix            = local.naming_prefix
}

module "s3_cf_policy" {
    for_each                      = module.s3_website
    source                        = "./modules/s3-cf-policy"
    bucket_id                     = each.value.static_website_id
    bucket_arn                    = each.value.static_website_arn
    cloudfront_distribution_arn   = module.cloud_front[each.key].cloudfront_distribution_arn
}

# Outputs for CloudFront URLs and S3 Bucket Names
output "cloudfront_urls" {
    value = { for k, v in module.cloud_front : k => v.cloudfront_distribution_domain_name }
}

output "s3_bucket_names" {
    value = { for k, v in module.s3_website : k => v.static_website_regional_domain_name }
}
