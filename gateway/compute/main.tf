# Public IP for Management
resource "azurerm_public_ip" "pan_mgmt_pip" {
  name                = "pan-mgmt-pip"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "mgmt_nsg" {
  name                = "nsg-paloalto-mgmt"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Network Interfaces
resource "azurerm_network_interface" "nic_mgmt" {
  name                = "pan-nic-mgmt"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.pan_mgmt_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pan_mgmt_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "mgmt_assoc" {
  network_interface_id      = azurerm_network_interface.nic_mgmt.id
  network_security_group_id = azurerm_network_security_group.mgmt_nsg.id
}

resource "azurerm_network_interface" "nic_trust" {
  name                = "pan-nic-trust"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.pan_trust_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic_untrust" {
  name                = "pan-nic-untrust"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name

  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.pan_untrust_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Palo Alto VM-Series BYOL
resource "azurerm_linux_virtual_machine" "pan_vm" {
  name                = "PAN-BYOL-FW01"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic_mgmt.id,
    azurerm_network_interface.nic_untrust.id,
    azurerm_network_interface.nic_trust.id
  ]

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
  }

  plan {
    name      = "byol"
    product   = "vmseries-flex"
    publisher = "paloaltonetworks"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}


output "pan_mgmt_public_ip" {
  value = azurerm_public_ip.pan_mgmt_pip.ip_address
}


