
variable "inst_name" {
  type        = string
  description = "Name of the EC2 instance"
}

variable "inst_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of the EC2 instance"
}

variable "st_reqd" {
  type        = number
  default     = 8
  description = "Storage required for the EC2 instance"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the EC2 instance"
}
