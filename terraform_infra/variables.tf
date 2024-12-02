variable "aws_region" {
    description = "The AWS region to deploy to"
    default     = "eu-west-1"
}

variable "cidr_block_range" {
    description = "The VPC cidr block range"
    default     = "10.0.0.0/16"
}

variable "availability_zones" {
    description = "List of availability zones"
    type        = list(string)
    default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "environment" {
    description = "The environment to deploy to (staging or production)"
    type        = string
}

variable "instance_type" {
    description = "EC2 instance type"
    default     = "t2.micro"
}

variable "db_instance_class" {
    description = "RDS instance class"
    default     = "db.t2.micro"
}

variable "db_password" {
    description = "Prod password"
    type        = string
}

variable "public_subnets" {
    description = "CIDR blocks for public subnets"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
    description = "CIDR blocks for application subnets"
    type        = list(string)
    default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "database_subnets" {
    description = "CIDR blocks for database subnets"
    type        = list(string)
    default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}


variable "website_buckets" {
    description = "List of website buckets"
    type        = list(string)
    default     = ["knowledgecity-web-react", "knowledgecity-web-svelte"]
}

variable "company" {
    type        = string
    description = "Company name for resource tagging"
    default     = "knowledgecity"
}

variable "additional_databases" {
    description = "List of additional database names to create"
    type        = list(string)
    default     = ["knowledgecity_media"]  # Add more names as needed
}


variable "video_bucket_name" {
    description = "The name of the S3 bucket for videos."
    type        = string
    default     = "knowledgecity-media-videos" 
}



