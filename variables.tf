variable "name" {
  description = "Name of VPC."
  type        = string
}

variable "cidr_block" {
  description = "CIDR Block for resource. Use a /24."
  type        = string

  validation {
    condition     = split("/", var.supernet)[1] == "24"
    error_message = "This module needs a /24."
  }
}

variable "tags" {
  description = "Map of tags to apply to the instance."
  type        = map(string)
  default     = {}
}