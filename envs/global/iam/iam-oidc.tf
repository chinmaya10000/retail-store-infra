module "iam_oidc_provider" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"
  version = "6.4.0"

  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}