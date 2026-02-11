resource "azurerm_virtual_network" "gateway_vnet" {
  name                = var.gateway_vnet_name
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name
  address_space       = [var.gateway_vnet_cidr]
}

resource "azurerm_subnet" "pan_mgmt" {
  name                 = var.gateway_vnet_panmanagement_subnet_name
  resource_group_name  = var.gateway_resource_group_name
  virtual_network_name = azurerm_virtual_network.gateway_vnet.name
  address_prefixes     = [var.gateway_vnet_panmanagement_subnet_cidr]
}

resource "azurerm_subnet" "pan_trust" {
  name                 = var.gateway_vnet_pantrust_subnet_name
  resource_group_name  = var.gateway_resource_group_name
  virtual_network_name = azurerm_virtual_network.gateway_vnet.name
  address_prefixes     = [var.gateway_vnet_pantrust_subnet_cidr]
}

resource "azurerm_subnet" "pan_untrust" {
  name                 = var.gateway_vnet_panuntrust_subnet_name
  resource_group_name  = var.gateway_resource_group_name
  virtual_network_name = azurerm_virtual_network.gateway_vnet.name
  address_prefixes     = [var.gateway_vnet_panuntrust_subnet_cidr]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = var.gateway_vnet_gateway_subnet_name
  resource_group_name  = var.gateway_resource_group_name
  virtual_network_name = azurerm_virtual_network.gateway_vnet.name
  address_prefixes     = [var.gateway_vnet_gateway_subnet_cidr]
}

resource "azurerm_subnet" "pan_custom" {
  name                 = var.gateway_vnet_pancustom_subnet_name
  resource_group_name  = var.gateway_resource_group_name
  virtual_network_name = azurerm_virtual_network.gateway_vnet.name
  address_prefixes     = [var.gateway_vnet_pancustom_subnet_cidr]
}

resource "azurerm_subnet" "pan_dev" {
  name                 = var.gateway_vnet_pandev_subnet_name
  resource_group_name  = var.gateway_resource_group_name
  virtual_network_name = azurerm_virtual_network.gateway_vnet.name
  address_prefixes     = [var.gateway_vnet_pandev_subnet_cidr]
}
