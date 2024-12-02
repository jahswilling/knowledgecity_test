variable "common_tags" {}
variable "naming_prefix" {}
variable "bucket_name" {}

variable "kms_key_arn" {
    description = "The KMS key ARN for encrypting the S3 bucket."
    type        = string
}

