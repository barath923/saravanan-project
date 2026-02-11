variable "hub_resource_group_name" {
  description = "Name of the resource group for the hub resources"
  type        = string
}

variable "hub_location" {
    description = "Azure region for the hub resources"
    type        = string
}

variable "hub_vms" {
  description = "Map of VMs to create with specific configurations."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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
variable "hub_jumpvms" {
  description = "Map of JumpVM."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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

# variable "last_vm_number" {
#   description = "Last allocated VM number"
#   type        = number
# }



#CLINICAL VARIABLES
variable "clinical_resource_group_name" {
  description = "Name of the resource group for the clinical resources"
  type        = string
}

variable "clinical_location" {
    description = "Azure region for the clinical resources"
    type        = string
}

variable "clinical_vms" {
  description = "Map of VMs to create with specific configurations."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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

variable "clinical_jumpvms" {
  description = "Map of JumpVM."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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


#NON - CLINICAL VARIABLES

variable "non_clinical_resource_group_name" {
  description = "Name of the resource group for the non-clinical resources"
  type        = string
}

variable "non_clinical_location" {
    description = "Azure region for the non-clinical resources"
    type        = string
}

variable "non_clinical_vms" {
  description = "Map of VMs to create with specific configurations."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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

variable "non_clinical_jumpvms" {
  description = "Map of JumpVM."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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

#VELOCITY

variable "velocity_resource_group_name" {
  description = "Name of the resource group for the velocity resources"
  type        = string
}

variable "velocity_location" {
    description = "Azure region for the velocity resources"
    type        = string
}

variable "velocity_vms" {
  description = "Map of VMs to create with specific configurations."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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

variable "velocity_jumpvms" {
  description = "Map of JumpVM."
  type = map(object({
    location       = string
    os_type        = string # "windows" or "linux"
    vm_size        = string
    admin_username = string
    # Password optional for Linux with SSH, mandatory for Windows
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

# Gateway VARIABLES

variable "gateway_resource_group_name" {
  description = "Name of the resource group for the gateway resources"
  type        = string
}

variable "gateway_location" {
    description = "Azure region for the gateway resources"
    type        = string
}

