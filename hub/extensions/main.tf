# https://www.citrix.com/downloads/workspace-app/windows/workspace-app-for-windows-latest23.html

locals {
  timezones = {
    centralindia   = "India Standard Time"
    eastus         = "Eastern Standard Time"
    eastus2        = "Eastern Standard Time"
    centralus      = "Central Standard Time"
    northcentralus = "Central Standard Time"
    southcentralus = "Central Standard Time"
    westcentralus  = "Central Standard Time"
    westus         = "Pacific Standard Time"
    westus2        = "Pacific Standard Time"
    westus3        = "Mountain Standard Time"
    canadaeast     = "Eastern Standard Time"
    canadacentral  = "Eastern Standard Time"
    brazilsouth    = "E. South America Standard Time"
    northeurope    = "GMT Standard Time"
    westeurope     = "Central Europe Standard Time"
    ukwest         = "GMT Standard Time"
    uksouth        = "GMT Standard Time"
    francecentral  = "Central Europe Standard Time"
    southeastasia  = "Singapore Standard Time"
  }
}

locals {
  jumpvm_timezones = {
    for k, v in var.jumpvms :
    k => lookup(local.timezones, v.location, null)
    if v.os_type == "windows"
  }
}

# Hard validation fail terraform plan/apply
resource "null_resource" "validate_jumpvm_timezone" {
  for_each = local.jumpvm_timezones

  lifecycle {
    precondition {
      condition     = each.value != null
      error_message = "Timezone mapping missing for Azure region '${var.jumpvms[each.key].location}'. Add it to locals.timezones."
    }
  }
}

resource "azurerm_virtual_machine_extension" "Jump_timez" {
  for_each = local.jumpvm_timezones

  name               = "Jump-TimeZone-${each.key}"
  virtual_machine_id = var.windows_vm_ids[each.key]

  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = <<-POWERSHELL
      powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Set-TimeZone -Id '${each.value}'"
    POWERSHELL
  })
}

locals {
  windows_vm_timezones = {
    for k, v in var.vms :
    k => lookup(local.timezones, v.location, null)
    if v.os_type == "windows" && v.install_software == true
  }
}

resource "null_resource" "validate_vm_timezone" {
  for_each = local.windows_vm_timezones

  lifecycle {
    precondition {
      condition     = each.value != null
      error_message = "Timezone mapping missing for Azure region '${var.vms[each.key].location}'. Add it to locals.timezones."
    }
  }
}

# resource "azurerm_virtual_machine_extension" "adobe_reader_install" {
#   for_each = {
#     for k, v in var.vms : k => v
#     if v.install_software == true && v.os_type == "windows"
#   }

#   name               = "AdobeReader-${each.key}"
#   virtual_machine_id = var.windows_vm_ids[each.key]

#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"

#   settings = jsonencode({
#     fileUris = [
#       "https://dontdeleteresource26.blob.core.windows.net/package-con/install_adobe.ps1"
#     ]
#     commandToExecute = "powershell -ExecutionPolicy Bypass -NoProfile -Command \"Set-TimeZone -Id 'India Standard Time'; powershell -ExecutionPolicy Bypass -NoProfile -File install_adobe.ps1\"" 
#   })
# }


resource "azurerm_virtual_machine_extension" "linux" {
  for_each = {
    for k, v in var.vms : k => v
    if v.install_software == true && v.os_type == "linux"
  }
  name               = "InstallSoftware-Linux-${each.key}"
  virtual_machine_id = var.linux_vm_ids[each.key]

  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode({
    commandToExecute = "timedatectl set-timezone Asia/Kolkata"
  })
}

