resource "aws_s3_bucket" "www_redirect_content" {
    provider = aws.oregon
    bucket = "${var.deploy_id}-www-redirect-content"

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }  

    lifecycle_rule { 
        id = "expire"
        enabled = true
        abort_incomplete_multipart_upload_days = 2
        
        expiration {
            days = 0
            expired_object_delete_marker = false
        }
    } 

    versioning {
        enabled = true
    }

    website {
        redirect_all_requests_to = "https://${data.aws_ssm_parameter.domain_name.value}"
    }
}

resource "aws_s3_bucket_public_access_block" "www_redirect_content" {
    provider = aws.oregon
    bucket = aws_s3_bucket.www_redirect_content.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}