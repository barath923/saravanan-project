# outputs

output "clinical_vnet_id" {
    value       = azurerm_virtual_network.clinical_vnet.id
    description = "The ID of the Clinical virtual network"
}

output "clinical_vnet_name" {
    value = azurerm_virtual_network.clinical_vnet.name
    description = "clinical vnet name"
}

output "management_subnet_id" {
    value       = azurerm_subnet.management.id
    description = "The ID of the management subnet"
}

output "subnet_one_id" {
    value       = azurerm_subnet.subnet_one.id
    description = "The ID of subnet one"
}

output "subnet_two_id" {
    value       = azurerm_subnet.subnet_two.id
    description = "The ID of subnet two"
}