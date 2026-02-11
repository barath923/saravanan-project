# outputs

output "gateway_vnet_id" {
  value = azurerm_virtual_network.gateway_vnet.id
}

output "gateway_vnet_name" {
  value = azurerm_virtual_network.gateway_vnet.name
}

output "pan_mgmt_subnet_id" {
  value = azurerm_subnet.pan_mgmt.id
}

output "pan_trust_subnet_id" {
  value = azurerm_subnet.pan_trust.id
}

output "pan_untrust_subnet_id" {
  value = azurerm_subnet.pan_untrust.id
}

output "gateway_subnet_id" {
  value = azurerm_subnet.gateway_subnet.id
}

output "pan_custom_subnet_id" {
  value = azurerm_subnet.pan_custom.id
}

output "pan_dev_subnet_id" {
  value = azurerm_subnet.pan_dev.id
}   