resource "azurerm_virtual_network" "non_clinical_vnet" {
  name                = var.non_clinical_vnet_name
  location            = var.non_clinical_location
  resource_group_name = var.non_clinical_resource_group_name
  address_space       = [var.non_clinical_vnet_cidr]
}

resource "azurerm_subnet" "management" {
  name                 = var.non_clinical_vnet_management_subnet_name
  resource_group_name  = var.non_clinical_resource_group_name
  virtual_network_name = azurerm_virtual_network.non_clinical_vnet.name
  address_prefixes     = [var.non_clinical_vnet_management_subnet_cidr]
}

resource "azurerm_subnet" "subnet_one" {
  name                 = var.non_clinical_vnet_subnet_one_name
  resource_group_name  = var.non_clinical_resource_group_name
  virtual_network_name = azurerm_virtual_network.non_clinical_vnet.name
  address_prefixes     = [var.non_clinical_vnet_shared_one_cidr]
}

resource "azurerm_subnet" "subnet_two" {
  name                 = var.non_clinical_vnet_shared_two_name
  resource_group_name  = var.non_clinical_resource_group_name
  virtual_network_name = azurerm_virtual_network.non_clinical_vnet.name
  address_prefixes     = [var.non_clinical_vnet_shared_two_cidr]
}

# Nat Gateway For Subnet one

resource "azurerm_public_ip" "subnet_one_nat_ip_non_clinical" {
  name                = "non-clinical-subnet-one-nat-pip"
  location            = var.non_clinical_location
  resource_group_name = var.non_clinical_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "subnet_one_nat_gateway_non_clinical" {
  name                  = "non-clinical-subnet-one-natgw"
  location              = var.non_clinical_location
  resource_group_name   = var.non_clinical_resource_group_name
  sku_name              = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "non_clinical_subnet_one_nat_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.subnet_one_nat_gateway_non_clinical.id
  public_ip_address_id = azurerm_public_ip.subnet_one_nat_ip_non_clinical.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_one" {
  subnet_id      = azurerm_subnet.subnet_one.id
  nat_gateway_id = azurerm_nat_gateway.subnet_one_nat_gateway_non_clinical.id
}

# Nat gateway for Subnet two

resource "azurerm_public_ip" "subnet_two_nat_ip_non_clinical" {
  name                = "non-clinical-subnet-two-nat-pip"
  location            = var.non_clinical_location
  resource_group_name = var.non_clinical_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "subnet_two_nat_gateway_non_clinical" {
  name                  = "non-clinical-subnet-two-natgw"
  location              = var.non_clinical_location
  resource_group_name   = var.non_clinical_resource_group_name
  sku_name              = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "non_clinical_subnet_two_nat_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.subnet_two_nat_gateway_non_clinical.id
  public_ip_address_id = azurerm_public_ip.subnet_two_nat_ip_non_clinical.id
}

resource "azurerm_subnet_nat_gateway_association" "non_clinical_subnet_two_nat_gateway_association" {
  subnet_id      = azurerm_subnet.subnet_two.id
  nat_gateway_id = azurerm_nat_gateway.subnet_two_nat_gateway_non_clinical.id
}