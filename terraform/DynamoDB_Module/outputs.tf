
output "dynamodb_table_arn" {
  value = aws_dynamodb_table.this.arn
}

output "dynamodb_table_id" {
  value = aws_dynamodb_table.this.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.this.name
}