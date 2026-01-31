
terraform {
  backend "s3" {}
}

provider "aws" {
  region = "ap-south-1"
}

variable "func_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

resource "aws_iam_role" "lambda_exec" {
  name        = var.func_name
  description = "Execution role for lambda function"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.func_name}-policy"
  description = "Policy for lambda function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "arn:aws:logs:*:*:*"
        Effect    = "Allow"
      },
      {
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
        ]
        Resource = "*"
        Effect    = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "lambda_func" {
  filename      = ""
  function_name = var.func_name
  handler       = ""
  runtime       = "python3.12"
  architectures = ["x86_64"]
  role          = aws_iam_role.lambda_exec.arn

  tags = var.tags
}

resource "aws_lambda_permission" "lambda_perm" {
  statement_id  = "AllowExecutionFromSES"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_func.function_name
  principal     = "ses.amazonaws.com"
}

output "lambda_arn" {
  value = aws_lambda_function.lambda_func.arn
}
