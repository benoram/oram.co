data "aws_iam_policy_document" "codebuild_assume_role" {
    provider = aws.oregon
    statement {
        actions   = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["codebuild.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "codebuild" {
    name = "${var.deploy_id}-codebuild"
    provider = aws.oregon
    assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}

data "aws_iam_policy_document" "codebuild_permissions" {
    provider = aws.oregon
    statement {
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]

        resources = [
            "*"
        ]
    }

    statement {
        actions = [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning",
            "s3:PutObject",
            "s3:GetBucketLocation"
        ]

        resources = [
            aws_s3_bucket.build_artifacts.arn,
            "${aws_s3_bucket.build_artifacts.arn}/*"
        ]
    }

    statement {
        actions = [
            "cloudfront:CreateInvalidation"
        ]

        resources = [
            "*"
        ]
    }

    statement {
        actions = [
            "ssm:GetParameters"
        ]

        resources = [
            "arn:aws:ssm:us-west-2:${data.aws_caller_identity.current.account_id}:parameter/${var.deploy_id}/*"
        ]
    }
}

resource "aws_iam_policy" "codebuild" {
    name = "${var.deploy_id}-codebuild"
    provider = aws.oregon
    policy = data.aws_iam_policy_document.codebuild_permissions.json
}

resource "aws_iam_role_policy_attachment" "codebuild" {
    provider = aws.oregon
    role       = aws_iam_role.codebuild.id
    policy_arn = aws_iam_policy.codebuild.arn
}