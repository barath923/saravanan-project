variable "velocity_resource_group_name" {
    type        = string
    description = "Name of the resource group for clinical resources"
}

variable "velocity_location" {
    type        = string
    description = "Azure region for clinical resources"
}


# Clinical Networking Variables
variable "velocity_vnet_name" {
    type        = string
    description = "Name of the clinical virtual network"
}

variable "velocity_vnet_cidr" {
    type        = string
    description = "CIDR block for the clinical virtual network"
}

variable "velocity_vnet_management_subnet_name" {
    type        = string
    description = "Name of the management subnet"
}

variable "velocity_vnet_management_subnet_cidr" {
    type        = string
    description = "CIDR block for the management subnet"
}

variable "velocity_vnet_subnet_one_name" {
    type        = string
    description = "Name of the first shared subnet"
}

variable "velocity_vnet_shared_one_cidr" {
    type        = string
    description = "CIDR block for the first shared subnet"
}

