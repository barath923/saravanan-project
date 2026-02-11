# outputs

output "velocity_vnet_id" {
    value       = azurerm_virtual_network.velocity_vnet.id
    description = "The ID of the Velocity virtual network"
}

output "velocity_vnet_name" {
    value       = azurerm_virtual_network.velocity_vnet.name
    description = "The name of the Velocity virtual network"
}

output "management_subnet_id" {
    value       = azurerm_subnet.management.id
    description = "The ID of the management subnet"
}

output "subnet_one_id" {
    value       = azurerm_subnet.subnet_one.id
    description = "The ID of subnet one"
}
