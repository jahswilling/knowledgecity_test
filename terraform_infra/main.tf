provider "aws" {
    region = var.aws_region
    profile = "knowledgecity"
}

terraform {
    required_version = ">= 1.3"

    backend "s3" {
        bucket         = "knowledgecity-state-bucket"
        key            = "terraform/state"
        region         = "eu-west-1"
        dynamodb_table = "knowledgecity-terraform-lock"
        encrypt        = true
    }
}


