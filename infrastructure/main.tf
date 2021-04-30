terraform {
    required_version = ">= 0.15, < 0.16"

    required_providers {  
        archive = {
            source = "hashicorp/archive"
            version = "~> 2.1.0"
        }
        
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.37.0"
        }
    }

    backend "remote" {
        organization = "benoram"
        workspaces {
            prefix = "oramco-website-infrastructure-"
        }
    }
}



provider "aws" {    
    alias  = "oregon"
    region = "us-west-2"
}

provider "aws" {    
    alias  = "virginia"
    region = "us-east-1"
}

data "aws_caller_identity" "current" {
    provider = aws.oregon
}
