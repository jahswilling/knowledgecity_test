
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "knowledgecity-vpc"
    cidr = var.cidr_block_range

    azs             = var.availability_zones
    public_subnets = var.public_subnets
    private_subnets  = var.private_subnets
    database_subnets = var.database_subnets

    enable_nat_gateway = true

    tags = {
        Terraform = "true"
        Environment = var.environment
    }
}

output "vpc_id" {
    value = module.vpc.vpc_id
}

