
variable "table_name" {
  type        = string
  description = "The name of the DynamoDB table"
}

variable "environment" {
  type        = string
  description = "The environment for which the table is being created"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the table"
  default     = {}
}
