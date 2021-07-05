provider "azurerm" {
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  features {
  }
}


module "az_westus2" {
  source                       = "./az_westus2"
  resource_location            = "westus2"
  resource_prefix              = "tf-wu2"
  resource_tags                = var.resource_tags
  admin_username = var.admin_username
  admin_password = var.admin_password
  vm_instance_size = "Standard_b1ls"
}

