
terraform {
  backend "s3" {}
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_lambda_function" "lambda_function" {
  filename      = "lambda_function_payload.zip"
  function_name = var.func_name
  handler       = "index.handler"
  runtime       = "python3.12"
  architectures = ["x86_64"]
  role          = aws_iam_role.lambda_exec.arn
  tags          = var.tags
}

resource "aws_iam_role" "lambda_exec" {
  name        = "${var.func_name}-lambda-exec"
  description = "Execution role for ${var.func_name} lambda function"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.func_name}-lambda-policy"
  description = "Policy for ${var.func_name} lambda function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Effect = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = "ses:*"
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

output "lambda_arn" {
  value = aws_lambda_function.lambda_function.arn
}
