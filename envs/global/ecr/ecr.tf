module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.2.0"

  for_each = toset(var.services)
  repository_name = "retail-store/${each.key}"

  repository_lifecycle_policy = jsonencode({
    rules = [
        {
            rulePriority = 1,
            description  = "Keep last 30 images",
            selection = {
                tagStatus     = "tagged",
                tagPrefixList = ["v"],
                countType     = "imageCountMoreThan",
                countNumber   = 30
            },
            action = {
                type = "expire"
            }
        }
    ]
  })
}
