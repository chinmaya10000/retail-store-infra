variable "region" {
  type        = string
  description = "AWS region to provision infrastructure."
}

variable "bucket" {
  type        = string
  description = "S3 bucket for terraform state."
}

variable "github_repo" {
  description = "GitHub repository in format org/repo"
  type        = string
}

variable "services" {
  description = "List of microservices"
  type        = list(string)
}
