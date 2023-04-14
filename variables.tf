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

variable "use_tgw" {
  description = "TGW attachment?"
  type = bool
  default = true
}

variable "route_table_id" {
  description = "Transit Gateway Route Table ID"
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