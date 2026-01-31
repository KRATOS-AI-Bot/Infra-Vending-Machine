
variable "func_name" {
  type        = string
  description = "The name of the lambda function"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to the lambda function"
  default     = {}
}
