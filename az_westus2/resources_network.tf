#########################################################################################################
##### VNets
#########################################################################################################

resource "azurerm_virtual_network" "virtual_network" {
  name                = "vn-${var.resource_prefix}-VMs"
  resource_group_name = azurerm_resource_group.resource_group_network_services.name
  location            = azurerm_resource_group.resource_group_network_services.location
  address_space       = ["172.16.0.0/16"]
  tags                = var.resource_tags
}

#########################################################################################################
##### Subnets
#########################################################################################################

resource "azurerm_subnet" "subnet_virtual_machines1" {
  name                 = "sn-${var.resource_prefix}-VM1"
  resource_group_name  = azurerm_resource_group.resource_group_network_services.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["172.16.1.0/24"]
}

#########################################################################################################
##### Security Groups
#########################################################################################################

resource "azurerm_network_security_group" "security_group_vms" {
  name                = "nsg-${var.resource_prefix}-vms"
  resource_group_name = azurerm_resource_group.resource_group_network_services.name
  location            = azurerm_resource_group.resource_group_network_services.location
  
  security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }  
  
  tags                = var.resource_tags
}

#########################################################################################################
##### Security Group Associations
#########################################################################################################

resource "azurerm_subnet_network_security_group_association" "security_group_assoc_vms1" {
  subnet_id                 = azurerm_subnet.subnet_virtual_machines1.id
  network_security_group_id = azurerm_network_security_group.security_group_vms.id
}
