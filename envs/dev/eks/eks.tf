 module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${var.env}-${var.eks_cluster_name}"
  kubernetes_version = var.eks_version

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids               = data.terraform_remote_state.vpc.outputs.private_subet_ids
#   control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    initial = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node group
      instance_types = var.general_nodes_ec2_types
      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  tags = {
    Environment = var.env
    Terraform   = "true"
  }
}

module "eks_blueprints_addons" {
  source = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  enable_aws_load_balancer_controller    = true
  #enable_cluster_proportional_autoscaler = true
  #enable_karpenter                       = true
  #enable_kube_prometheus_stack           = true
  enable_metrics_server                  = true

  enable_cluster_autoscaler           = true
  cluster_autoscaler = {
    set = [
      {
        name  = "extraArgs.scale-down-unneeded-time"
        value = "1m"
      },
      {
        name  = "extraArgs.skip-nodes-with-local-storage"
        value = "false"
      },
      {
        name  = "extraArgs.skip-nodes-with-system-pods"
        value = "false"
      }
    ]
  }
}
