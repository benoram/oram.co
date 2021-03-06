resource "aws_ssm_parameter" "cloudfront_apex" {
    provider = aws.oregon

    name  = "/${var.deploy_id}/content/distribution-id"
    type  = "String"
    value = aws_cloudfront_distribution.apex_content.id
}

resource "aws_ssm_parameter" "s3_apex" {
    provider = aws.oregon

    name  = "/${var.deploy_id}/content/bucket-name"
    type  = "String"
    value = aws_s3_bucket.apex_content.bucket
}
