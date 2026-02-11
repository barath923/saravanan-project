variable "clinical_resource_group_name" {
    type        = string
    description = "Name of the resource group for clinical resources"
}

variable "clinical_location" {
    type        = string
    description = "Azure region for clinical resources"
}


# Clinical Networking Variables
variable "clinical_vnet_name" {
    type        = string
    description = "Name of the clinical virtual network"
}

variable "clinical_vnet_cidr" {
    type        = string
    description = "CIDR block for the clinical virtual network"
}

variable "clinical_vnet_management_subnet_name" {
    type        = string
    description = "Name of the management subnet"
}

variable "clinical_vnet_management_subnet_cidr" {
    type        = string
    description = "CIDR block for the management subnet"
}

variable "clinical_vnet_subnet_one_name" {
    type        = string
    description = "Name of the first shared subnet"
}

variable "clinical_vnet_shared_one_cidr" {
    type        = string
    description = "CIDR block for the first shared subnet"
}

variable "clinical_vnet_shared_two_name" {
    type        = string
    description = "Name of the second shared subnet"
}

variable "clinical_vnet_shared_two_cidr" {
    type        = string
    description = "CIDR block for the second shared subnet"
}


# NAT Gateway Variables
variable "clinical_nat_gateway_name" {
    type        = string
    description = "Name of the NAT gateway"
}

variable "clinical_nat_public_ip_name" {
    type        = string
    description = "Name of the public IP for NAT gateway"
}