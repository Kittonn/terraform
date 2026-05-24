variable "subnet_count" {
  type        = number
  default     = 2
  description = "The number of subnets to create."
}

variable "ec2_instance_count" {
  type        = number
  default     = 4
  description = "The number of EC2 instances to create."
}

variable "ec2_instance_config" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only ubuntu and nginx AMIs are allowed for EC2 instance configuration."
  }

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config : contains(["t3.micro"], config.instance_type)
    ])
    error_message = "Only t3.micro instance type is allowed for EC2 instance configuration."
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only ubuntu and nginx AMIs are allowed for EC2 instance configuration."
  }

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t3.micro"], config.instance_type)
    ])
    error_message = "Only t3.micro instance type is allowed for EC2 instance configuration."
  }
}

variable "subnet_config_map" {
  type = map(object({
    cidr_block = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config_map) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "Each subnet CIDR block must be in the format 10.0.X.0/24 where X is a number between 0 and 255."
  }
}
