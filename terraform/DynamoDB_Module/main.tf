
provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {}
}

resource "aws_dynamodb_table" "table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.tags
}

resource "aws_dynamodb_table_item" "item" {
  table_name = aws_dynamodb_table.table.name
  hash_key   = aws_dynamodb_table.table.hash_key

  item = <<ITEM
{
  "id": {"S": "1"}
}
ITEM
}

output "table_name" {
  value = aws_dynamodb_table.table.name
}

output "table_arn" {
  value = aws_dynamodb_table.table.arn
}
