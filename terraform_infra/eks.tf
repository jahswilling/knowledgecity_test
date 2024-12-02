module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"

    cluster_name    = "knowledgecity-eks"
    cluster_version = "1.31"

    # Public access to the control plane endpoint (can be restricted via CIDR blocks if needed)
    cluster_endpoint_public_access  = true

    # Add default EKS-managed add-ons
    cluster_addons = {
        coredns                = {}
        eks-pod-identity-agent = {}
        kube-proxy             = {}
        vpc-cni                = {}
    }

    # VPC and subnet configuration from VPC module
    vpc_id                   = module.vpc.vpc_id
    subnet_ids               = module.vpc.private_subnets
    control_plane_subnet_ids = module.vpc.private_subnets

    # EKS Managed Node Groups configuration
    eks_managed_node_group_defaults = {
        instance_types = ["t3.medium"]
    }

    eks_managed_node_groups = {
        default = {
        ami_type       = "AL2023_x86_64_STANDARD"
        instance_types = ["t3.medium"]

        min_size     = 1
        max_size     = 5
        desired_size =1
        }
    }

    # Add cluster creator as administrator
    enable_cluster_creator_admin_permissions = true

    # Tags for resources created by the module
    tags = {
        Environment = var.environment
        Terraform   = "true"
    }
}
