
variable "table_name" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "environment" {
  type        = string
  description = "Environment where the table will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the DynamoDB table"
  default     = {}
}
