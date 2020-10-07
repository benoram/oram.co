resource "aws_cloudfront_distribution" "www_redirect" {
  provider = aws.oregon
  comment             = "WWW Redirect"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All" 
  aliases = ["www.${data.aws_ssm_parameter.domain_name.value}"]
  
  origin {      
    domain_name = aws_s3_bucket.www_redirect.website_endpoint    
    origin_id = "s3-redirect"

    custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-redirect"
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    compress = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.tls_www.certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}

resource "aws_route53_record" "www_ipv4" {
  provider = aws.oregon
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${data.aws_ssm_parameter.domain_name.value}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_redirect.domain_name
    zone_id                = aws_cloudfront_distribution.www_redirect.hosted_zone_id
    evaluate_target_health = false # You can't set to true with CloudFront
  }
}

resource "aws_route53_record" "www_ipv6" {
  provider = aws.oregon
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${data.aws_ssm_parameter.domain_name.value}"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.www_redirect.domain_name
    zone_id                = aws_cloudfront_distribution.www_redirect.hosted_zone_id
    evaluate_target_health = false # You can't set to true with CloudFront
  }
}