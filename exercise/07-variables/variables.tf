variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in."
  default     = "ap-southeast-1"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.micro"], var.ec2_instance_type)
    error_message = "The EC2 instance type must be one of: t3.micro, t2.micro."
  }
}

variable "ec2_volume_config" {
  type = object({
    volume_size = number
    volume_type = string
  })

  description = "Configuration for the EC2 instance's root block device."

  default = {
    volume_size = 10
    volume_type = "gp3"
  }
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "my_sensitive_variable" {
  type        = string
  sensitive   = true
  description = "This is an example of a sensitive variable. Its value will be hidden in Terraform outputs and logs."
}
