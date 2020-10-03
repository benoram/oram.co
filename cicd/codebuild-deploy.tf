resource "aws_cloudwatch_log_group" "codebuild_deploy" {
    name = "/aws/codebuild/${var.deploy_id}/deploy"
    provider = aws.oregon
    retention_in_days = 7
}

resource "aws_codebuild_project" "deploy" {
    name = "${var.deploy_id}-deploy"
    provider = aws.oregon
    description = "Deploy the ${var.domain_name} website"
    build_timeout = "5" # 5 minutes
    service_role = aws_iam_role.codebuild.arn

    artifacts {
        type = "CODEPIPELINE"
    }

    environment {
        compute_type = "BUILD_GENERAL1_SMALL"
        image = "aws/codebuild/standard:4.0"
        type = "LINUX_CONTAINER"
        image_pull_credentials_type = "CODEBUILD"

        environment_variable {
            name = "SAM_CLI_TELEMETRY"
            value = "1"
        }
    }

    logs_config {
        cloudwatch_logs {
            group_name  = aws_cloudwatch_log_group.codebuild_deploy.name
        }
    }

    source {
        type = "CODEPIPELINE"
        buildspec = "deploy/buildspec.yaml"
    }
}