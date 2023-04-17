variable "name" {
  description = "Name of VPC."
  type        = string
}

variable "network_domain_name" {
  description = "Name of Network Domain."
  type        = string
  default     = null
}

variable "cidr_block" {
  description = "CIDR Block for resource. Use a /24."
  type        = string

  validation {
    condition     = split("/", var.cidr_block)[1] == "24"
    error_message = "This module needs a /24."
  }
}

variable "tgw_attachment" {
  description = "Details of TGW attachment."
  type = object(
    {
      tgw_id                     = string,
      association_route_table_id = string,
      propagation_route_table_id = optional(string)
    }
  )
  default = null
}

variable "tags" {
  description = "Map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}

locals {


  network_domain_name = var.network_domain_name == null ? {} : { Network_Domain = var.network_domain_name }

  tags = merge(
    { Name = var.name },
    local.network_domain_name,
    var.tags
  )

  workload_tags = merge(
    { Name = "${var.name}-workload" },
    local.network_domain_name,
    var.tags
  )

  tgw_tags = merge(
    { Name = "${var.name}-tgw" },
    local.network_domain_name,
    var.tags
  )
}