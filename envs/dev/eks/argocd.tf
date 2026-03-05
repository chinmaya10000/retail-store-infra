# resource "helm_release" "argocd" {
#   name = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart = "argo-cd"
#   namespace = "argocd"
#   create_namespace = true
#   version = "9.4.7"

#   values = [file("values/argocd.yaml")]

#   depends_on = [ module.eks ]
# }

# resource "kubernetes_secret" "argocd_gitops_repo" {
#   depends_on = [
#     helm_release.argocd
#   ]

#   metadata {
#     name      = "gitops-k8s-repo"
#     namespace = "argocd"
#     labels = {
#       "argocd.argoproj.io/secret-type" = "repository"
#     }
#   }

#   data = {
#     type : "git"
#     url : var.gitops_url
#     username : var.gitops_username
#     password : var.gitops_password
#   }

#   type = "Opaque"
# }
