resource "aws_acm_certificate" "tls_www" {
  provider = aws.virginia
  domain_name = "www.${data.aws_ssm_parameter.domain_name.value}"
  validation_method = "DNS"
}

resource "aws_route53_record" "tls_www_certvalidation" {
  provider = aws.virginia
  for_each = {
    for dvo in aws_acm_certificate.tls_www.domain_validation_options : dvo.domain_name => {
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

resource "aws_acm_certificate_validation" "tls_www" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.tls_www.arn
  validation_record_fqdns = [for record in aws_route53_record.tls_www_certvalidation : record.fqdn]
}