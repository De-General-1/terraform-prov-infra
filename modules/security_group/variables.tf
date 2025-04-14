variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the SG will be created"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
