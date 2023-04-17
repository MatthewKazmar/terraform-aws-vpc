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
  type        = bool
  default     = true
}

variable "association_route_table_id" {
  description = "Associate VPC to this route table id."
  type        = string
  default     = null
}

variable "propagation_route_table_id" {
  description = "Propagate VPC CIDR to this route table id, if different than the association."
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}