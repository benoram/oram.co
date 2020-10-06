data "aws_ssm_parameter" "domain_name" {
  name = "/${var.deploy_id}/domain/name"
}