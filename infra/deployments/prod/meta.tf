terraform {
//  backend "s3" {
//    bucket = "2022-warsztaty-state"
//    key    = "terraform.tfstate"
//    region = "eu-central-1"
//    profile = "warsztaty_iac"
//    dynamodb_table = "state-lock-dynamo"
//  }

  backend "local" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.1"
    }
  }
}

provider "aws" {
  profile = "warsztaty_iac"
  region = "eu-central-1"
}
