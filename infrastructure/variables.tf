# AWS
variable "AWS_ACCESS_KEY_ID" { type = string }
variable "AWS_SECRET_ACCESS_KEY" { type = string }

## Project level settings
variable "deploy_id" { type = string }

locals {
    // For dev environments we prefix our deploy_id with dev-. There are times we need to know
    // if the script/build is for dev or prod.
    terraform_environment = trimprefix(var.deploy_id, "dev-") == var.deploy_id  ? "prod" : "dev"
    isDev = local.terraform_environment == "dev"
    isProd = local.terraform_environment == "prod"
}