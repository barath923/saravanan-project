resource "azurerm_virtual_network" "velocity_vnet" {
  name                = var.velocity_vnet_name
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name
  address_space       = [var.velocity_vnet_cidr]
}

resource "azurerm_subnet" "management" {
  name                 = var.velocity_vnet_management_subnet_name
  resource_group_name  = var.velocity_resource_group_name
  virtual_network_name = azurerm_virtual_network.velocity_vnet.name
  address_prefixes     = [var.velocity_vnet_management_subnet_cidr]
}

resource "azurerm_subnet" "subnet_one" {
  name                 = var.velocity_vnet_subnet_one_name
  resource_group_name  = var.velocity_resource_group_name
  virtual_network_name = azurerm_virtual_network.velocity_vnet.name
  address_prefixes     = [var.velocity_vnet_shared_one_cidr]
}

# Nat Gateway For Subnet one

resource "azurerm_public_ip" "subnet_one_nat_ip_velocity" {
  name                = "velocity-subnet-one-nat-pip"
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "subnet_one_nat_gateway_velocity" {
  name                  = "velocity-subnet-one-natgw"
  location              = var.velocity_location
  resource_group_name   = var.velocity_resource_group_name
  sku_name              = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "velocity_subnet_one_nat_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.subnet_one_nat_gateway_velocity.id
  public_ip_address_id = azurerm_public_ip.subnet_one_nat_ip_velocity.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_one" {
  subnet_id      = azurerm_subnet.subnet_one.id
  nat_gateway_id = azurerm_nat_gateway.subnet_one_nat_gateway_velocity.id
}

