# AWS
variable "AWS_ACCESS_KEY_ID" { type = string }
variable "AWS_SECRET_ACCESS_KEY" { type = string }

## Project level settings
variable "deploy_id" { type = string }

locals {
    // We append -dev or -prod on our Terraform environments, and use the same convention
    // for the deploy_id var associated with the terraform environment.
    // This value will be used by the Infrastructure script, since it needs to pick
    // a terraform environment to deploy to. And could be used other places too.
    terraform_environment = trimsuffix(var.deploy_id, "dev") == var.deploy_id  ? "dev" : "prod"
    isDev = local.terraform_environment == "dev"
    isProd = local.terraform_environment == "prod"
}