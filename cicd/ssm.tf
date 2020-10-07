resource "aws_ssm_parameter" "team_token" {
    provider = aws.oregon

    name  = "/${var.deploy_id}/terraform/team-token"
    type  = "SecureString"
    value = var.terraform_team_token
}

resource "aws_ssm_parameter" "domain_name" {
    provider = aws.oregon

    name  = "/${var.deploy_id}/domain/name"
    type  = "String"
    value = var.domain_name
}
