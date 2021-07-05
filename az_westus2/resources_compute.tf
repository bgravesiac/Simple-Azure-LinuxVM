#########################################################################################################
##### Availability Sets
#########################################################################################################

#resource "azurerm_availability_set" "availability_set_vm" {
#  name                        = "as-${var.resource_prefix}-VM"
#  resource_group_name         = azurerm_resource_group.resource_group_vm.name
#  location                    = azurerm_resource_group.resource_group_vm.location
#  platform_fault_domain_count = 2 
#  tags                        = var.resource_tags
#}


#########################################################################################################
##### Public IP Address
#########################################################################################################

resource "azurerm_public_ip" "vm_public_ip" {
    name                         = "vm_public_ip"
    resource_group_name          = azurerm_resource_group.resource_group_vm.name
    location                     = azurerm_resource_group.resource_group_vm.location
	allocation_method            = "Dynamic"
	domain_name_label            = "test123987"
    tags                         = var.resource_tags
    }



#########################################################################################################
##### Network Interfaces
#########################################################################################################

resource "azurerm_network_interface" "network_interface_vm" {
  count               = 1
  name                = "netint-${var.resource_prefix}-VM0${count.index + 1}"
  location            = azurerm_resource_group.resource_group_vm.location
  resource_group_name = azurerm_resource_group.resource_group_vm.name
  tags                = var.resource_tags

  ip_configuration {
    name                          = "VM-IPCONFIG1"
    subnet_id                     = azurerm_subnet.subnet_virtual_machines1.id
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

#########################################################################################################
##### Virtual Machines
#########################################################################################################
# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { 
    value = tls_private_key.example_ssh.private_key_pem 
    sensitive = true
}
resource "azurerm_linux_virtual_machine" "virtual_machine_test" {
  count                 = 1
  name                  = "${var.resource_prefix}-VM0${count.index + 1}"
  resource_group_name   = azurerm_resource_group.resource_group_vm.name
  location              = azurerm_resource_group.resource_group_vm.location
  size                  = var.vm_instance_size
#  availability_set_id   = azurerm_availability_set.availability_set_vm.id
#  timezone              = "GMT Standard Time"
  tags                  = var.resource_tags
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  admin_ssh_key { 
	username            = var.admin_username
	public_key 	        = file("~/.ssh/id_rsa.pub")
	}
  
  network_interface_ids = [
    azurerm_network_interface.network_interface_vm[count.index].id,
  ]

  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
    #disk_encryption_set_id = azurerm_disk_encryption_set.disk_encryption_set.id
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


}

#########################################################################################################
##### Managed Disks
#########################################################################################################

resource "azurerm_managed_disk" "managed_disk_vm_s" {
  count                = 1
  name                 = "${var.resource_prefix}-VM0${count.index + 1}_DataDisk_S"
  location             = azurerm_resource_group.resource_group_vm.location
  resource_group_name  = azurerm_resource_group.resource_group_vm.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 20
  tags                 = var.resource_tags
}


#########################################################################################################
##### Virtual Machine Extensions
#########################################################################################################

#
#
#
