resource "aws_cloudwatch_log_group" "codebuild_infrastructure" {
    name = "/aws/codebuild/${var.deploy_id}/infrastructure"
    provider = aws.oregon
    retention_in_days = 7
}

resource "aws_codebuild_project" "infrastructure" {
    name = "${var.deploy_id}-infrastructure"
    provider = aws.oregon
    description = "Terraform deploy for infrastructure - ${var.domain_name}"
    build_timeout = "30" # 30 minutes
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

        environment_variable {
            name = "TERRAFORM_TEAM_TOKEN"
            type = "PARAMETER_STORE"
            value = "/${var.deploy_id}/terraform/team-token"
        }

        environment_variable {
            name = "TERRAFORM_ENVIRONMENT"
            value = local.terraform_environment
        }
    }

    logs_config {
        cloudwatch_logs {
            group_name  = aws_cloudwatch_log_group.codebuild_infrastructure.name
        }
    }

    source {
        type = "CODEPIPELINE"
        buildspec = "infrastructure/buildspec.yaml"
    }
}