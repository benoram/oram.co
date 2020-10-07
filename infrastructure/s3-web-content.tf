resource "aws_s3_bucket" "apex_content" {
    provider = aws.oregon
    bucket = "${var.deploy_id}-apex-content"

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

    website {
        index_document = "index.html"
    }

    versioning {
        enabled = true
    }
}

resource "aws_s3_bucket_public_access_block" "apex_content" {
    provider = aws.oregon
    bucket = aws_s3_bucket.apex_content.id

    block_public_acls       = true
    block_public_policy     = false
    ignore_public_acls      = true
    restrict_public_buckets = false
}

data "aws_iam_policy_document" "apex_content" {    
    provider = aws.oregon
    statement {
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = ["*"]
        }
        actions = [
            "s3:GetObject"
        ]

        resources = [            
            aws_s3_bucket.apex_content.arn,
            "${aws_s3_bucket.apex_content.arn}/*"
        ]
    }
}

resource "aws_s3_bucket_policy" "apex_content" {
    provider = aws.oregon
    bucket = aws_s3_bucket.apex_content.id
    policy = data.aws_iam_policy_document.apex_content.json
}
