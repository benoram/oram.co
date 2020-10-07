data "aws_ssm_parameter" "domain_name" {
  name = "/${var.deploy_id}/domain/name"
}

data "aws_route53_zone" "main" {
  name = data.aws_ssm_parameter.domain_name.value
}