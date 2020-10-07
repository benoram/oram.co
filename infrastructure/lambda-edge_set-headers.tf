data "archive_file" "security_headers_code" {
    type        = "zip"
    source_dir  = "lambda-edge/security-headers"
    output_path = "lambda-edge/security-headers/function.zip"
}

resource "aws_lambda_function" "set_security_headers" {
    provider         = aws.virginia
    filename         = "lambda-edge/security-headers/function.zip"
    function_name    = "${var.deploy_id}-cloudfront-set-security-headers"
    role             = aws_iam_role.lambda_edge_iam.arn
    handler          = "set-headers.handler"
    source_code_hash = data.archive_file.security_headers_code.output_base64sha256
    runtime          = "nodejs12.x"
    publish          = true
}

resource "aws_lambda_permission" "set_security_headers" {
    provider      = aws.virginia
    action        = "lambda:GetFunction"
    function_name = aws_lambda_function.set_security_headers.arn
    principal     = "edgelambda.amazonaws.com"
}

data "aws_iam_policy_document" "lambda_edge_assume_role" {
    provider = aws.oregon
    statement {
        actions   = ["sts:AssumeRole"]
        effect = "Allow"

        principals {
            type        = "Service"
            identifiers = [
                "lambda.amazonaws.com",
                "edgelambda.amazonaws.com"
            ]
        }
    }
}

resource "aws_iam_role" "lambda_edge_iam" {
    provider = aws.virginia
    assume_role_policy = data.aws_iam_policy_document.lambda_edge_assume_role.json
}

data "aws_iam_policy_document" "lambda_edge_permissions" {
    provider = aws.oregon
    statement {
        effect = "Allow"
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]
        resources = [
            "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:*"
        ]        
    }
    statement {
        effect = "Allow"
        actions = [
            "lambda:GetFunction"
        ]
        resources = [
            "${aws_lambda_function.set_security_headers.arn}:*"
        ]        
    }
}

resource "aws_iam_role_policy" "lambda_edge_policy" {
    provider = aws.virginia
    role = aws_iam_role.lambda_edge_iam.id
    policy = data.aws_iam_policy_document.lambda_edge_permissions.json
}