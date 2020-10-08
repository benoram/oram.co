terraform {
    required_version = ">= 0.13, < 0.14"

    required_providers {  
        archive = {
            source = "hashicorp/archive"
            version = "~> 1.3.0"
        }
        
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.9.0"
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
