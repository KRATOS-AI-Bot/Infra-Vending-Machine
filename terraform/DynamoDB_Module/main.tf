
provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {}
}

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.tags
}

resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
  "id": {"S": "1"}
}
ITEM
}

resource "aws_iam_policy" "this" {
  name        = "dynamodb-policy"
  description = "Policy for DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = aws_dynamodb_table.this.arn
      }
    ]
  })
}

resource "aws_iam_role" "this" {
  name        = "dynamodb-role"
  description = "Role for DynamoDB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
