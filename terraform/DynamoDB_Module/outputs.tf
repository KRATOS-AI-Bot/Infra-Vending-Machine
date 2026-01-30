
output "dynamodb_table_arn" {
  value = aws_dynamodb_table.table.arn
}

output "dynamodb_table_id" {
  value = aws_dynamodb_table.table.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.table.name
}