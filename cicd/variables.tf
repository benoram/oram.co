# AWS
variable "AWS_ACCESS_KEY_ID" { type = string }
variable "AWS_SECRET_ACCESS_KEY" { type = string }

# GitHub (used by CodePipeline)
variable "github_codestar_connection_arn" { type = string }
variable "github_owner" { type = string }
variable "github_repository" { type = string }
variable "github_branch_name" { type = string }

## Project level settings
variable "deploy_id" { type = string }
variable "domain_name" { type = string }

