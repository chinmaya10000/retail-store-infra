# # IRSA Role for EBS CSI Driver
# module "ebs_csi_irsa_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version = "~> 5.0"

#   role_name             = "${var.eks_cluster_name}-ebs-csi"
#   attach_ebs_csi_policy = true

#   oidc_providers = {
#     ex = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
#     }
#   }
# }

# # gp3 as default StorageClass (best practice over gp2)
# resource "kubernetes_storage_class_v1" "gp3" {
#   metadata {
#     name = "gp3"
#     annotations = {
#       "storageclass.kubernetes.io/is-default-class" = "true"
#     }
#   }

#   storage_provisioner    = "ebs.csi.aws.com"
#   volume_binding_mode    = "WaitForFirstConsumer"  # waits for pod scheduling before provisioning
#   allow_volume_expansion = true

#   parameters = {
#     type      = "gp3"
#     encrypted = "true"
#   }

#   depends_on = [ module.ebs_csi_irsa_role ]
# }