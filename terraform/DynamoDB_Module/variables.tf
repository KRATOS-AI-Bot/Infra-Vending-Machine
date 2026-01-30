
variable "table_name" {
  type        = string
  description = "The name of the DynamoDB table"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the table"
  default     = {}
}
