data "aws_iam_policy_document" "codepipeline_assume_role" {
    provider = aws.oregon
    statement {
        actions   = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["codepipeline.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "codepipeline" {
    name = "${var.deploy_id}-codepipeline"
    provider = aws.oregon
    assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json
}

data "aws_iam_policy_document" "codepipeline_permissions" {
    provider = aws.oregon

    statement {
        actions = [
          "s3:*"
        ]

        resources = [
            aws_s3_bucket.build_artifacts.arn,
            "${aws_s3_bucket.build_artifacts.arn}/*"
        ]
  }

    statement {
        actions = [
            "codestar-connections:GetInstallationUrl",
            "codestar-connections:GetConnection",
            "codebuild:BatchGetBuilds",
            "codestar-connections:GetIndividualAccessToken",
            "codestar-connections:UseConnection",
            "codestar-connections:StartOAuthHandshake",
            "codestar-connections:PassConnection",
            "codebuild:StartBuild"
        ]

        resources = [
            "*"
        ]
    }
}

resource "aws_iam_policy" "codepipeline" {
    name = "${var.deploy_id}-codepipeline"
    provider = aws.oregon
    policy = data.aws_iam_policy_document.codepipeline_permissions.json
}

resource "aws_iam_role_policy_attachment" "codepipeline" {
    provider = aws.oregon
    role       = aws_iam_role.codepipeline.id
    policy_arn = aws_iam_policy.codepipeline.arn
}