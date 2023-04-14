variable "name" {
  description = "Name of VPC."
  type        = string
}

variable "cidr_block" {
  description = "CIDR Block for resource. Use a /24."
  type        = string

  validation {
    condition     = split("/", var.cidr_block)[1] == "24"
    error_message = "This module needs a /24."
  }
}

variable "tgw_id" {
  description = "ID of AWS TGW. Leave blank to skip attaching to the TGW."
  type        = string
  default     = null
}

variable "network_domain" {
  description = "Network Domain name. Specifies Route Table. Don't specify to use default TGW table."
  type        = string
  default     = null
}

variable "propagate" {
  description = "Propagate VPC CIDRs to the specified Network Domain."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}

locals {
  use_tgw            = var.tgw_id == null ? 0 : 1
  use_network_domain = var.tgw_id == null ? 0 : var.network_domain == null ? 0 : 1
}