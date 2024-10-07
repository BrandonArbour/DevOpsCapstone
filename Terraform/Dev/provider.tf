terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.69.0"
    }
  }
}

provider "aws" {
  region  = "ca-central-1"
  profile = "BrandonArbourCapstone-terraform"
}