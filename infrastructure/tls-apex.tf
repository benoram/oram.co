resource "aws_acm_certificate" "tls_apex" {
  provider = aws.virginia
  domain_name = data.aws_ssm_parameter.domain_name.value
  validation_method = "DNS"
}

resource "aws_route53_record" "tls_apex_certvalidation" {
  provider = aws.virginia
  for_each = {
    for dvo in aws_acm_certificate.tls_apex.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "tls_apex" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.tls_apex.arn
  validation_record_fqdns = [for record in aws_route53_record.tls_apex_certvalidation : record.fqdn]
}