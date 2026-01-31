
provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {}
}

resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = var.func_name
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec.arn
  architectures = ["x86_64"]
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = resource.local_file.placeholder.filename
  output_path = "${path.module}/lambda_function_payload.zip"
}

resource "local_file" "placeholder" {
  filename = "${path.module}/placeholder.py"
  content  = "def lambda_handler(e, c): print('Hello Kratos')"
}

resource "aws_iam_role" "lambda_exec" {
  name        = "${var.func_name}-lambda-exec"
  description = "Execution role for ${var.func_name} lambda function"

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
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

variable "func_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}
