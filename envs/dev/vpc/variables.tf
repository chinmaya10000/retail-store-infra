variable "env" {
  description = "Environment name."
}

variable "region" {
  description = "AWS region to provision infrastructure."
}

variable "vpc_cidr" {
  description = "CIDR range for the AWS virtual private cloud."
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR range for the private subnet."
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR range for the public subnet."
}

variable "eks_cluster_name" {
  description = "Name of the Amazon EKS cluster."
}

variable "terraform_s3_bucket" {
  type        = string
  description = "An S3 bucket to store the Terraform state."
}
