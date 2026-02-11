variable "vms" {
  description = "VM configuration map used for deciding extensions"
  type = map(object({
    location         = string
    os_type          = string
    vm_size          = string
    admin_username   = string
    admin_password   = optional(string)
    publisher        = string
    offer            = string
    sku              = string
    version          = string
    os_disk_caching  = string
    subnet_type      = string
    install_software = optional(bool, false)
    attach_public_ip = optional(bool, false)
    private_ip       = string
  }))
}

variable "windows_vm_ids" {
  description = "Map of Windows VM IDs"
  type        = map(string)
}

variable "linux_vm_ids" {
  description = "Map of Linux VM IDs"
  type        = map(string)
}

variable "location_map" {
  description = "Map of VM names to Azure locations"
  type        = map(string)
}

variable "jumpvms" {
  description = "VM configuration map used for deciding extensions for Jump VMs"
  type = map(object({
    location         = string
    os_type          = string
    vm_size          = string
    admin_username   = string
    admin_password   = optional(string)
    publisher        = string
    offer            = string
    sku              = string
    version          = string
    os_disk_caching  = string
    subnet_type      = string
    install_software = optional(bool, false)
    attach_public_ip = optional(bool, false)
    private_ip       = string
  }))
}

