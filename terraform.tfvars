#REF TIMEZONE REGIONS
    # centralindia   = "India Standard Time"
    # eastus         = "Eastern Standard Time"
    # eastus2        = "Eastern Standard Time"
    # centralus      = "Central Standard Time"
    # northcentralus = "Central Standard Time"
    # southcentralus = "Central Standard Time"
    # westcentralus  = "Central Standard Time"
    # westus         = "Pacific Standard Time"
    # westus2        = "Pacific Standard Time"
    # westus3        = "Mountain Standard Time"
    # canadaeast     = "Eastern Standard Time"
    # canadacentral  = "Eastern Standard Time"
    # brazilsouth    = "E. South America Standard Time"
    # northeurope    = "GMT Standard Time"
    # westeurope     = "Central Europe Standard Time"
    # ukwest         = "GMT Standard Time"
    # uksouth        = "GMT Standard Time"
    # francecentral  = "Central Europe Standard Time"
    # southeastasia  = "Singapore Standard Time"



hub_resource_group_name = "my-hub-resource-group"
hub_location = "East US"
# hub_jumpvms = {
#   "hub-jump-01" = {
#     location         = "eastus"
#     os_type          = "windows"
#     vm_size          = "Standard_B2s"
#     admin_username   = "winadmin"
#     admin_password   = "Password1234!"
#     publisher        = "MicrosoftWindowsServer"
#     offer            = "WindowsServer"
#     sku              = "2019-Datacenter"
#     version          = "latest"
#     os_disk_caching  = "ReadWrite"
#     subnet_type      = "mgmt"
#     install_software = false
#     attach_public_ip = true
#     private_ip       = "172.20.0.10"
#     nsg_type         = "mgmt"
#   } 
# }
# hub_vms = {
#  "hub-app-01" = {
#   location         = "eastus"
#   os_type          = "linux"
#   vm_size          = "Standard_B2s"
#   admin_username   = "azureuser"
#   publisher        = "Canonical"
#   offer            = "0001-com-ubuntu-server-jammy"
#   sku              = "22_04-lts"
#   version          = "latest"
#   os_disk_caching  = "ReadWrite"
#   subnet_type      = "mgmt"
#   attach_public_ip = true
#   install_software = true
#   private_ip       = "172.20.0.11"
#   nsg_type         = "shared"
# }
# }

#last_vm_number = 0


#############CLINICAL VARIABLES

clinical_resource_group_name = "my-clinical-resource-group"
clinical_location = "East US 2"

# clinical_jumpvms = {
#   "clinic-jump-01" = {
#     location         = "eastus2"
#     os_type          = "windows"
#     vm_size          = "Standard_B2s"
#     admin_username   = "winadmin"
#     admin_password   = "Password1234!"
#     publisher        = "MicrosoftWindowsServer"
#     offer            = "WindowsServer"
#     sku              = "2019-Datacenter"
#     version          = "latest"
#     os_disk_caching  = "ReadWrite"
#     subnet_type      = "mgmt"
#     install_software = false
#     attach_public_ip = true
#     private_ip       = "172.20.2.138"  
#     nsg_type         = "mgmt"
#   } 
# }

# clinical_vms = {
#  "clini-app-01" = {
#   location         = "eastus2"
#   os_type          = "linux"
#   vm_size          = "Standard_B2s"
#   admin_username   = "azureuser"
#   admin_password   = "linux@12345#"
#   publisher        = "Canonical"
#   offer            = "0001-com-ubuntu-server-jammy"
#   sku              = "22_04-lts"
#   version          = "latest"
#   os_disk_caching  = "ReadWrite"
#   subnet_type      = "subnet1"
#   attach_public_ip = true
#   install_software = true
#   private_ip       = "172.20.2.170"
#   nsg_type         = "shared"
# }
# }

############# NON - CLINICAL VARIABLES

non_clinical_resource_group_name = "my-non-clinical-resource-group"
non_clinical_location = "Central US"

# non_clinical_jumpvms = {
#   "non-cli-jump1" = {
#     location         = "centralus"
#     os_type          = "windows"
#     vm_size          = "Standard_B2s"
#     admin_username   = "winadmin"
#     admin_password   = "Password1234!"
#     publisher        = "MicrosoftWindowsServer"
#     offer            = "WindowsServer"
#     sku              = "2019-Datacenter"
#     version          = "latest"
#     os_disk_caching  = "ReadWrite"
#     subnet_type      = "mgmt"
#     install_software = false
#     attach_public_ip = true
#     private_ip       = "172.20.3.138"  
#     nsg_type         = "mgmt"
#   } 
# }

# non_clinical_vms = {
#  "non-cli-app1" = {
#   location         = "centralus"
#   os_type          = "linux"
#   vm_size          = "Standard_B2s"
#   admin_username   = "azureuser"
#   admin_password   = "linux@12345#"
#   publisher        = "Canonical"
#   offer            = "0001-com-ubuntu-server-jammy"
#   sku              = "22_04-lts"
#   version          = "latest"
#   os_disk_caching  = "ReadWrite"
#   subnet_type      = "subnet1"
#   attach_public_ip = true
#   install_software = true
#   private_ip       = "172.20.3.170"
#   nsg_type         = "shared"
# }
# }


############# VELOCITY VARIABLES

velocity_resource_group_name = "my-velocity-resource-group"
velocity_location = "West US"

# velocity_jumpvms = {
#   "velocity-jump1" = {
#     location         = "westus"
#     os_type          = "windows"
#     vm_size          = "Standard_B2s"
#     admin_username   = "winadmin"
#     admin_password   = "Password1234!"
#     publisher        = "MicrosoftWindowsServer"
#     offer            = "WindowsServer"
#     sku              = "2019-Datacenter"
#     version          = "latest"
#     os_disk_caching  = "ReadWrite"
#     subnet_type      = "mgmt"
#     install_software = true
#     attach_public_ip = true
#     private_ip       = "172.20.4.100"  
#     nsg_type         = "mgmt"
#   } 
# }

# velocity_vms = {
#  "velocity-app1" = {
#   location         = "westus"
#   os_type          = "linux"
#   vm_size          = "Standard_B2s"
#   admin_username   = "azureuser"
#   admin_password   = "linux@12345#"
#   publisher        = "Canonical"
#   offer            = "0001-com-ubuntu-server-jammy"
#   sku              = "22_04-lts"
#   version          = "latest"
#   os_disk_caching  = "ReadWrite"
#   subnet_type      = "subnet1"
#   attach_public_ip = true
#   install_software = true
#   private_ip       = "172.20.4.119"
#   nsg_type         = "shared"
# }
# }

#Gateway VARIABLES
gateway_resource_group_name = "my-gateway-resource-group"
gateway_location = "West US 2"
