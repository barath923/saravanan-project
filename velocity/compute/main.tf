locals {
  all_vms_map = merge(var.jumpvms, var.vms)
}

locals {
  nsg_map = {
    mgmt   = azurerm_network_security_group.jump_vm_nsg.id
    subnet1 = azurerm_network_security_group.shared_nsg.id
  }
}

# NSG for jump vm
resource "azurerm_network_security_group" "jump_vm_nsg" {
  name                = "velocity-jump-nsg"
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name

  security_rule {
    name                       = "AllowRDPInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"     # Standard RDP port
    source_address_prefix      = "Internet" # Allow RDP from any source IP (be careful with this in production)
    destination_address_prefix = "*"
  } 
  # Additional rules can be added here
}

#shared nsg
resource "azurerm_network_security_group" "shared_nsg" {
  name                = "velocity-shared-nsg"
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name

  security_rule {
    name                       = "AllowsshInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"          # Standard SSH port
    source_address_prefix      = "10.0.3.0/24" # Allow SSH from any source IP (be careful with this in production)
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowRDPInbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"        # Standard RDP port
    source_address_prefix      = "10.0.3.0/24" # Allow RDP from any source IP (be careful with this in production)
    destination_address_prefix = "*"
  }
  # Additional rules can be added here
}

resource "azurerm_public_ip" "pip" {
  for_each = {
    for k, v in local.all_vms_map : k => v
    if v.attach_public_ip == true
  }

  name                = "${each.key}-ip"
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  for_each = local.all_vms_map

  name                = "${each.key}-nic"
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = each.value.private_ip != null ? "Static" : "Dynamic"
    private_ip_address            = each.value.private_ip
    subnet_id = each.value.subnet_type == "mgmt" ? var.management_subnet_id : each.value.subnet_type == "subnet1" ? var.subnet_one_id : null
    public_ip_address_id = each.value.subnet_type == "mgmt" ? azurerm_public_ip.pip[each.key].id : null
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  for_each = local.all_vms_map
  network_interface_id = azurerm_network_interface.nic[each.key].id
  network_security_group_id = local.nsg_map[each.value.subnet_type]
}

resource "azurerm_windows_virtual_machine" "windows" {
  for_each = {
    for k, v in local.all_vms_map : k => v if v.os_type == "windows"
  }

  name                = each.key
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name
  size                = each.value.vm_size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-datacenter"
        version   = "latest"
    }
}

resource "azurerm_linux_virtual_machine" "linux" {
  for_each = {
    for k, v in local.all_vms_map : k => v if v.os_type == "linux"
  }

  name                = each.key
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name
  size                = each.value.vm_size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password
  
  disable_password_authentication = false
  
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}


