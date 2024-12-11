aws_region = "us-east-1"

variable "bucket_name" {
  default = "aws-bucket-dhana"
}

provider "aws" {
  region = var.aws_region
}