resource "aws_cloudfront_distribution" "apex_content" {
    provider = aws.oregon
    comment             = "Content"
    enabled             = true
    is_ipv6_enabled     = true
    price_class         = "PriceClass_All" 
    aliases = [data.aws_ssm_parameter.domain_name.value]
  
    origin {      
        domain_name = aws_s3_bucket.apex_content.website_endpoint    
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
        viewer_protocol_policy = "redirect-to-https"

        forwarded_values {
            query_string = true

            cookies {
                forward = "none"
            }
        }
        lambda_function_association {
            event_type = "origin-response"
            include_body = false
            lambda_arn = aws_lambda_function.set_security_headers.qualified_arn
        }

        compress = true
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate_validation.tls_apex.certificate_arn
        ssl_support_method = "sni-only"
        minimum_protocol_version = "TLSv1.2_2019"
    }
}

resource "aws_route53_record" "apex_ipv4" {
    provider = aws.oregon
    zone_id = data.aws_route53_zone.main.zone_id
    name    = data.aws_ssm_parameter.domain_name.value
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.apex_content.domain_name
        zone_id                = aws_cloudfront_distribution.apex_content.hosted_zone_id
        evaluate_target_health = false # You can't set to true with CloudFront
    }
}

resource "aws_route53_record" "apex_ipv6" {
    provider = aws.oregon
    zone_id = data.aws_route53_zone.main.zone_id
    name    = data.aws_ssm_parameter.domain_name.value
    type    = "AAAA"

    alias {
        name                   = aws_cloudfront_distribution.apex_content.domain_name
        zone_id                = aws_cloudfront_distribution.apex_content.hosted_zone_id
        evaluate_target_health = false # You can't set to true with CloudFront
    }
}