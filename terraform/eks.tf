module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  # Karpenter가 노드를 관리하므로 최소 1개만 유지
  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 1
      desired_size   = 1
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
  
  # 현재 terraform 실행하는 IAM 유저/Role에 자동으로 admin 권한 부여
  enable_cluster_creator_admin_permissions = true
}