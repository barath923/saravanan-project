#Hub Vpn Gateway

resource "azurerm_public_ip" "hub_vpn_pip" {
  name                = "hub-vpn-pip"
  location            = var.hub_location
  resource_group_name = var.hub_resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}


resource "azurerm_virtual_network_gateway" "hub_vpn_gw" {
  name                = "hub-vpn-gateway"
  location            = var.hub_location
  resource_group_name = var.hub_resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"

  active_active = false
  enable_bgp    = false

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.hub_vpn_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.hub_subnet_gateway_id
  }
}


#
resource "azurerm_route_table" "gateway_rt" {
  name                = "gateway-rt"
  location            = var.gateway_location
  resource_group_name = var.gateway_resource_group_name

  route {
    name                   = "to-clinical"
    address_prefix         = "172.20.2.0/24"     #CIDR OF CLINICAL
    next_hop_type          = "VirtualNetworkGateway"
  }
  
  route {
    name                   = "to-non-clinical"
    address_prefix         = "172.20.3.0/24"     #CIDR OF NON-CLINICAL
    next_hop_type          = "VirtualNetworkGateway"
  }

  route {
    name                   = "to-velocity"
    address_prefix         = "172.20.4.0/24"     #CIDR OF VELOCITY
    next_hop_type          = "VirtualNetworkGateway"
  }
}

resource "azurerm_route_table" "velocity_rt" {
  name                = "velocity-rt"
  location            = var.velocity_location
  resource_group_name = var.velocity_resource_group_name

  route {
    name                   = "to-gateway"
    address_prefix         = "172.22.0.0/24"     #CIDR OF GATEWAY
    next_hop_type          = "VirtualNetworkGateway"
  }
  
  route {
    name                   = "to-non-clinical"
    address_prefix         = "172.20.3.0/24"     #CIDR OF NON-CLINICAL
    next_hop_type          = "VirtualNetworkGateway"
  }

  route {
    name                   = "to-clinical"
    address_prefix         = "172.20.2.0/24"     #CIDR OF CLINICAL
    next_hop_type          = "VirtualNetworkGateway"
  }
}

resource "azurerm_route_table" "clinical_rt" {
  name                = "clinical-rt"
  location            = var.clinical_location
  resource_group_name = var.clinical_resource_group_name

  route {
    name                   = "to-gateway"
    address_prefix         = "172.22.0.0/24"     #CIDR OF GATEWAY
    next_hop_type          = "VirtualNetworkGateway"
  }
  
  route {
    name                   = "to-non-clinical"
    address_prefix         = "172.20.3.0/24"     #CIDR OF NON-CLINICAL
    next_hop_type          = "VirtualNetworkGateway"
  }

  route {
    name                   = "to-velocity"
    address_prefix         = "172.20.4.0/24"     #CIDR OF VELOCITY
    next_hop_type          = "VirtualNetworkGateway"
  }
}

resource "azurerm_route_table" "non_clinical_rt" {
  name                = "non_clinical-rt"
  location            = var.non_clinical_location
  resource_group_name = var.non_clinical_resource_group_name

  route {
    name                   = "to-gateway"
    address_prefix         = "172.22.0.0/24"     #CIDR OF GATEWAY
    next_hop_type          = "VirtualNetworkGateway"
  }
  
  route {
    name                   = "to-clinical"
    address_prefix         = "172.20.2.0/24"     #CIDR OF CLINICAL
    next_hop_type          = "VirtualNetworkGateway"
  }

  route {
    name                   = "to-velocity"
    address_prefix         = "172.20.4.0/24"     #CIDR OF VELOCITY
    next_hop_type          = "VirtualNetworkGateway"
  }
}


#################################
# Gateway Route Table Association
#################################

resource "azurerm_subnet_route_table_association" "gateway_rt_assoc_pan_custom_subnet_id" {
  subnet_id      = var.pan_custom_subnet_id
  route_table_id = azurerm_route_table.gateway_rt.id
}

resource "azurerm_subnet_route_table_association" "gateway_rt_assoc_pan_dev_subnet_id" {
  subnet_id      = var.pan_dev_subnet_id
  route_table_id = azurerm_route_table.gateway_rt.id
}

#################################
# Velocity Route Table Association
#################################

resource "azurerm_subnet_route_table_association" "velocity_rt_assoc_velocity_management_subnet_id" {
  subnet_id      = var.velocity_management_subnet_id
  route_table_id = azurerm_route_table.velocity_rt.id
}

resource "azurerm_subnet_route_table_association" "velocity_rt_assoc_velocity_subnet_one_id" {
  subnet_id      = var.velocity_subnet_one_id
  route_table_id = azurerm_route_table.velocity_rt.id
}

#################################
# Clinical Route Table Association
#################################

resource "azurerm_subnet_route_table_association" "clinical_rt_assoc_clinical_management_subnet_id" {
  subnet_id      = var.clinical_management_subnet_id
  route_table_id = azurerm_route_table.clinical_rt.id
}

resource "azurerm_subnet_route_table_association" "clinical_rt_assoc_clinical_subnet_one_id" {
  subnet_id      = var.clinical_subnet_one_id
  route_table_id = azurerm_route_table.clinical_rt.id
}

resource "azurerm_subnet_route_table_association" "clinical_rt_assoc_clinical_subnet_two_id" {
  subnet_id      = var.clinical_subnet_two_id
  route_table_id = azurerm_route_table.clinical_rt.id
}

#################################
# Non-Clinical Route Table Association
#################################

resource "azurerm_subnet_route_table_association" "non_clinical_rt_assoc_non_clinical_management_subnet_id" {
  subnet_id      = var.non_clinical_management_subnet_id
  route_table_id = azurerm_route_table.non_clinical_rt.id
}

resource "azurerm_subnet_route_table_association" "non_clinical_rt_assoc_non_clinical_subnet_one_id" {
  subnet_id      = var.non_clinical_subnet_one_id
  route_table_id = azurerm_route_table.non_clinical_rt.id
}

resource "azurerm_subnet_route_table_association" "non_clinical_rt_assoc_non_clinical_subnet_two_id" {
  subnet_id      = var.non_clinical_subnet_two_id
  route_table_id = azurerm_route_table.non_clinical_rt.id
}



#### PRERING WITH HUB

# VNet Peering (Hub ↔ gateway)
# Hub → gateway
resource "azurerm_virtual_network_peering" "hub_to_gateway" {
  name                      = "hub-to-gateway"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = var.gateway_vnet_id
  
  # allow_vnet_access         = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

# Gateway → Hub
resource "azurerm_virtual_network_peering" "gateway_to_hub" {
  name                      = "gateway-to-hub"
  resource_group_name       = var.gateway_resource_group_name
  virtual_network_name      = var.gateway_vnet_name
  remote_virtual_network_id = var.hub_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  use_remote_gateways     = true
}


# VNet Peering (Hub ↔ velocity)
# Hub → velocity
resource "azurerm_virtual_network_peering" "hub_to_velocity" {
  name                      = "hub-to-velocity"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = var.velocity_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  allow_gateway_transit   = true
}

# velocity → Hub
resource "azurerm_virtual_network_peering" "velocity_to_hub" {
  name                      = "velocity-to-hub"
  resource_group_name       = var.velocity_resource_group_name
  virtual_network_name      = var.velocity_vnet_name
  remote_virtual_network_id = var.hub_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  use_remote_gateways     = true
}

# VNet Peering (Hub ↔ clinical)
# Hub → clinical
resource "azurerm_virtual_network_peering" "hub_to_clinical" {
  name                      = "hub-to-clinical"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = var.clinical_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  allow_gateway_transit   = true
}

# clinical → Hub
resource "azurerm_virtual_network_peering" "clinical_to_hub" {
  name                      = "clinical-to-hub"
  resource_group_name       = var.clinical_resource_group_name
  virtual_network_name      = var.clinical_vnet_name
  remote_virtual_network_id = var.hub_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  use_remote_gateways     = true
}

# VNet Peering (Hub ↔ non-clinical)
# Hub → non-clinical
resource "azurerm_virtual_network_peering" "hub_to_non_clinical" {
  name                      = "hub-to-non-clinical"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = var.non_clinical_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  allow_gateway_transit   = true
}

# non-clinical → Hub
resource "azurerm_virtual_network_peering" "non_clinical_to_hub" {
  name                      = "non-clinical-to-hub"
  resource_group_name       = var.non_clinical_resource_group_name
  virtual_network_name      = var.non_clinical_vnet_name
  remote_virtual_network_id = var.hub_vnet_id

  # allow_vnet_access       = true
  allow_forwarded_traffic = true
  use_remote_gateways     = true
}


##### GATEWAY WITH CLINICAL, NON-CLINICAL, VELOCITY PEERING

# VNet Peering (gateway ↔ clinical)
# gateway → clinical  

resource "azurerm_virtual_network_peering" "gateway_to_clinical" {
  name                      = "gateway-to-clinical"
  resource_group_name       = var.gateway_resource_group_name
  virtual_network_name      = var.gateway_vnet_name
  remote_virtual_network_id = var.clinical_vnet_id

  allow_forwarded_traffic = true
}

# clinical → gateway
resource "azurerm_virtual_network_peering" "clinical_to_gateway" {
  name                      = "clinical-to-gateway"
  resource_group_name       = var.clinical_resource_group_name
  virtual_network_name      = var.clinical_vnet_name
  remote_virtual_network_id = var.gateway_vnet_id

  allow_forwarded_traffic = true
}

# VNet Peering (gateway ↔ non-clinical)
# gateway → non-clinical

resource "azurerm_virtual_network_peering" "gateway_to_non_clinical" {
  name                      = "gateway-to-non-clinical"
  resource_group_name       = var.gateway_resource_group_name
  virtual_network_name      = var.gateway_vnet_name
  remote_virtual_network_id = var.non_clinical_vnet_id

  allow_forwarded_traffic = true
}

# non-clinical → gateway
resource "azurerm_virtual_network_peering" "non_clinical_to_gateway" {  
  name                      = "non-clinical-to-gateway"
  resource_group_name       = var.non_clinical_resource_group_name
  virtual_network_name      = var.non_clinical_vnet_name
  remote_virtual_network_id = var.gateway_vnet_id

  allow_forwarded_traffic = true
}

# VNet Peering (gateway ↔ velocity)
# gateway → velocity
resource "azurerm_virtual_network_peering" "gateway_to_velocity" {
  name                      = "gateway-to-velocity"
  resource_group_name       = var.gateway_resource_group_name
  virtual_network_name      = var.gateway_vnet_name
  remote_virtual_network_id = var.velocity_vnet_id

  allow_forwarded_traffic = true
}

# velocity → gateway
resource "azurerm_virtual_network_peering" "velocity_to_gateway" {
  name                      = "velocity-to-gateway"
  resource_group_name       = var.velocity_resource_group_name
  virtual_network_name      = var.velocity_vnet_name
  remote_virtual_network_id = var.gateway_vnet_id

  allow_forwarded_traffic = true
}

