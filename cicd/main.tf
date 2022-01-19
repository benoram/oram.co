terraform {
    required_version = ">= 1.1, < 1.2"

    required_providers {  
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.72.0"
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
