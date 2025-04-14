module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" 
  cluster_version = "1.29"

  cluster_endpoint_public_access = true
  cluster_name = var.cluster_name

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  eks_managed_node_groups = {
    default_node_group = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.micro"]

      iam_role_arn = var.node_group_role_arn
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
