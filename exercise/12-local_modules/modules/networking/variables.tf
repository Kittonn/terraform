variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The vpc_cidr variable must be a valid CIDR block (e.g., 10.0.0.0/16)"
  }
}

variable "subnet_config" {
  type = map(object({
    az         = string
    cidr_block = string
    public     = optional(bool, false)
  }))

  validation {
    error_message = "Each subnet's cidr_block must be a valid CIDR block"
    condition = alltrue([
      for subnet in values(var.subnet_config) : can(cidrnetmask(subnet.cidr_block))
    ])
  }
}
