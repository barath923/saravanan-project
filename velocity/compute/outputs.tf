#outputs 

output "windows_vm_ids" {
  value = {
    for k, v in azurerm_windows_virtual_machine.windows :
    k => v.id
  }
}

output "linux_vm_ids" {
  value = {
    for k, v in azurerm_linux_virtual_machine.linux :
    k => v.id
  }
}

output "location_map" {
  value = {
    for k, v in local.all_vms_map :
    k => v.location
  }
}
