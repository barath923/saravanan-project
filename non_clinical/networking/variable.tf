variable "non_clinical_resource_group_name" {
    type        = string
    description = "Name of the resource group for non-clinical resources"
}

variable "non_clinical_location" {
    type        = string
    description = "Azure region for non-clinical resources"
}


# Non-Clinical Networking Variables
variable "non_clinical_vnet_name" {
    type        = string
    description = "Name of the non-clinical virtual network"
}

variable "non_clinical_vnet_cidr" {
    type        = string
    description = "CIDR block for the non-clinical virtual network"
}

variable "non_clinical_vnet_management_subnet_name" {
    type        = string
    description = "Name of the management subnet"
}

variable "non_clinical_vnet_management_subnet_cidr" {
    type        = string
    description = "CIDR block for the management subnet"
}

variable "non_clinical_vnet_subnet_one_name" {
    type        = string
    description = "Name of the first shared subnet"
}

variable "non_clinical_vnet_shared_one_cidr" {
    type        = string
    description = "CIDR block for the first shared subnet"
}

variable "non_clinical_vnet_shared_two_name" {
    type        = string
    description = "Name of the second shared subnet"
}

variable "non_clinical_vnet_shared_two_cidr" {
    type        = string
    description = "CIDR block for the second shared subnet"
}


