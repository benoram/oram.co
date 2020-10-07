// Make sure out CodeBuild projects have necessary access to infrastructure

data "aws_iam_role" "codebuild" {
    provider = aws.oregon
    name = "${var.deploy_id}-codebuild"
}

data "aws_iam_policy_document" "codebuild_permissions_infrastructure" {
    provider = aws.oregon
    statement {
        actions = [
            "s3:DeleteObject",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:PutObject"
        ]

        resources = [
            aws_s3_bucket.apex_content.arn,
            "${aws_s3_bucket.apex_content.arn}/*"
        ]
    }
}

resource "aws_iam_policy" "codebuild_infrastructure" {
    provider = aws.oregon
    name = "${var.deploy_id}-codebuild-infrastructure"    
    policy = data.aws_iam_policy_document.codebuild_permissions_infrastructure.json
}

resource "aws_iam_role_policy_attachment" "codebuild_infrastructure" {
    provider = aws.oregon
    role       = data.aws_iam_role.codebuild.id
    policy_arn = aws_iam_policy.codebuild_infrastructure.arn
}