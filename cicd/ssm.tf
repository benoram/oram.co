resource "aws_ssm_parameter" "foo" {
    provider = aws.oregon

    name  = "/${var.deploy_id}/terraform/team_token"
    type  = "SecureString"
    value = var.terraform_team_token
}