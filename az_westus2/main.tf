resource "azurerm_resource_group" "resource_group_network_services" {
  name     = "rg-${var.resource_prefix}-network"
  location = var.resource_location
  tags     = var.resource_tags
}

resource "azurerm_resource_group" "resource_group_vm" {
  name     = "rg-${var.resource_prefix}-vm"
  location = var.resource_location
  tags     = var.resource_tags
}
