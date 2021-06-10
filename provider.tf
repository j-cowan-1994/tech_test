provider "aws" {
  region  = var.region
}

terraform {
  required_version = "0.14.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.33.0"
    }
  }
}
