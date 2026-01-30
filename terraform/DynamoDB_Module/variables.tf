
variable "table_name" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to the DynamoDB table"
}
