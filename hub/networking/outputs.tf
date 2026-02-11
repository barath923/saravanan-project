#output subnet ids

output "hub_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.vnet.name
} 

output "subnet_shared_id" {
  value = azurerm_subnet.shared.id
}

output "subnet_mgmt_id" {
  value = azurerm_subnet.mgmt.id
} 

output "hub_subnet_gateway_id" {
  value = azurerm_subnet.gateway.id
}