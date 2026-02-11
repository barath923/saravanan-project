variable "clinical_resource_group_name" {
    description = "Azure resource group for clinical resources"
    type        = string
}

variable "clinical_location" {
    description = "Azure region for clinical resources"
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

variable "management_subnet_id" {
    description = "Subnet ID for management subnet one"
    type        = string
}

variable "subnet_one_id" {
    description = "Subnet ID for subnet one"
    type        = string
}

variable "subnet_two_id" {
    description = "Subnet ID for subnet two"
    type        = string
}