data "aws_ssm_parameter" "domain_name" {
    provider = aws.oregon
    name = "/${var.deploy_id}/domain/name"
}

data "aws_route53_zone" "main" {
    provider = aws.oregon
    name = data.aws_ssm_parameter.domain_name.value
}