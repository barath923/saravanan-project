# outputs

output "non_clinical_vnet_id" {
    value       = azurerm_virtual_network.non_clinical_vnet.id
    description = "The ID of the Non-Clinical virtual network"
}

output "non_clinical_vnet_name" {
    value       = azurerm_virtual_network.non_clinical_vnet.name
    description = "Name of the Non-Clinical Virtual Network"
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