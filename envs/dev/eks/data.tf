data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.terraform_s3_bucket
    key    = "dev/vpc/terraform.tfstate"
    region = var.region
  }
}
