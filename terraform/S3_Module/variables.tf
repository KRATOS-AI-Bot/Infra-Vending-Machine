
variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the S3 bucket"
  default     = {}
}
