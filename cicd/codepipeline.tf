resource "aws_codepipeline" "codepipeline" {
    name = var.deploy_id
    provider = aws.oregon
    role_arn = aws_iam_role.codepipeline.arn

    artifact_store {
        location = aws_s3_bucket.build_artifacts.bucket
        type = "S3"
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            version          = "1"
            output_artifacts = ["source_output"]

            configuration = {
                BranchName     = var.github_branch_name
                ConnectionArn = var.github_codestar_connection_arn
                FullRepositoryId = "${var.github_owner}/${var.github_repository}"
                OutputArtifactFormat = "CODE_ZIP"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"

            configuration = {
                ProjectName = aws_codebuild_project.web.name
            }
        }
    }

    stage {
        name = "Infrastructure"

        action {
            name             = "Infrastructure"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["iac_output"]
            version          = "1"

            configuration = {
                ProjectName = aws_codebuild_project.infrastructure.name
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name             = "Deploy"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["build_output"]
            output_artifacts = ["deploy_output"]
            version          = "1"

            configuration = {
                ProjectName = aws_codebuild_project.deploy.name
            }
        }
    }
}