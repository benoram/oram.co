resource "aws_s3_bucket" "build_artifacts" {
    provider = aws.oregon
    bucket = "${var.deploy_id}-artifacts"

    server_side_encryption_configuration {
        rule {
            // Encrypt all the things
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
            // Purge artifacts after 30 days
            days = 30
        }

        noncurrent_version_expiration {
            // Purge old versions after 30 days
            days = 30
        }
    } 

    versioning {
        enabled = true
    }
}

resource "aws_s3_bucket_public_access_block" "build_artifacts" {
    //Enforce that our bucket and objets cannot be public
    provider = aws.oregon
    bucket = aws_s3_bucket.build_artifacts.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}