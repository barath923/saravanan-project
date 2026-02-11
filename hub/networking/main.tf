# Hub Virtual Network and Subnets
resource "azurerm_virtual_network" "vnet" {
  name                = var.hub_vnet_name
  location            = var.hub_location
  resource_group_name = var.hub_resource_group_name
  address_space       = [var.hub_vnet_cidr]
}

resource "azurerm_subnet" "shared" {
  name                 = var.hub_vnet_shared_subnet_name
  resource_group_name  = var.hub_resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.hub_vnet_shared_subnet_cidr]
}

resource "azurerm_subnet" "mgmt" {
  name                 = var.hub_vnet_management_subnet_name
  resource_group_name  = var.hub_resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.hub_vnet_management_subnet_cidr]
}

resource "azurerm_subnet" "gateway" {
  name                 = var.hub_vnet_gateway_subnet_name
  resource_group_name  = var.hub_resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.hub_vnet_gateway_subnet_cidr]
}

#Nat Gateway and Public IP
resource "azurerm_public_ip" "nat_ip" {
  name                = var.hub_nat_public_ip_name
  location            = var.hub_location
  resource_group_name = var.hub_resource_group_name
  allocation_method   = "Static"
  sku                 = var.hub_nat_sku_name
} 

resource "azurerm_nat_gateway" "shared" {
  name                  = var.hub_nat_gateway_name
  location              = var.hub_location
  resource_group_name   = var.hub_resource_group_name
  sku_name              = var.hub_nat_sku_name
  idle_timeout_in_minutes = var.hub_nat_idle_timeout
}

#Mapping ip with Nat gateway
resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.shared.id
  public_ip_address_id = azurerm_public_ip.nat_ip.id
}

#Associating Nat with Subnet
resource "azurerm_subnet_nat_gateway_association" "shared" {
  subnet_id      = azurerm_subnet.shared.id
  nat_gateway_id = azurerm_nat_gateway.shared.id
}

