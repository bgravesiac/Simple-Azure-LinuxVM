variable "resource_location" {
  description = "Desired location to provision the resources."
  type        = string
}

variable "resource_prefix" {
  description = "Desired prefix for the provisioned resources."
  type        = string
}

variable "resource_tags" {
  description = "Desired tags which should be applied to all resources"
  type        = map
}

variable "admin_username" {
  description = "Appropriate value which will be used to log into the instance"
  type        = string
}

variable "admin_password" {
  description = "Appropriate value which will be used to log into the instance"
  type        = string
}

variable "vm_instance_size" {
  description = "Size of vm instance to deploy"
  type        = string
}