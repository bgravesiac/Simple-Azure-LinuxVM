variable "resource_tags" {
  description = "Tags applied to resources created"
  type        = map
  default     = {
    Environment     = "Test"
    Deployment = "Terraform"
  }
}

variable "admin_username" {
  description = "Appropriate value which will be used to log into the instance"
  type        = string
  default     = "azadmin"
}

variable "admin_password" {
  description = "Appropriate value which will be used to log into the instance"
  type        = string
  default     = ""
}