variable "name" {
  type        = string
  description = "The Name tag for the EC2 instance"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type (e.g., t2.micro)"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID where the EC2 instance will be launched"
}

variable "security_group_id" {
  type        = string
  description = "The ID of the security group to associate with the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "The name of the SSH key pair to use for the EC2 instance"
}
