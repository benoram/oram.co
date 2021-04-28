terraform {
    required_version = ">= 0.15, < 0.16"

    required_providers {  
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.37.0"
        }
    }

    backend "remote" {
        organization = "benoram"
        workspaces {
            prefix = "oramco-website-cicd-"
        }
    }
}

provider "aws" {    
    alias  = "oregon"
    region = "us-west-2"
}

data "aws_caller_identity" "current" {
    provider = aws.oregon
}
