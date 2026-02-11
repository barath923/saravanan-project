variable "resource_group_name" {
  description = "Resource group name for compute resources"
  type        = string
}

variable "location" {
  description = "Azure region for compute resources"
  type        = string
}

variable "vms" {
  description = "Map of application VMs"
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
  default = {}
}

variable "jumpvms" {
  description = "Map of jump VMs"
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
  default = {}
}

variable "subnet_mgmt_id" {
  description = "Management subnet ID"
  type        = string
}

variable "subnet_shared_id" {
  description = "Shared subnet ID"
  type        = string
}

