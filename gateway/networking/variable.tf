variable "gateway_resource_group_name" {
    type        = string
    description = "Name of the resource group for gateway resources"
}

variable "gateway_location" {
    type        = string
    description = "Azure region for gateway resources"
}

# Gateway Networking Variables
variable "gateway_vnet_name" {
    type        = string
    description = "Name of the gateway virtual network"
}

variable "gateway_vnet_cidr" {
    type        = string
    description = "CIDR block for the gateway virtual network"
}

variable "gateway_vnet_panmanagement_subnet_name" {
    type        = string
    description = "Name of the pan management subnet"
}

variable "gateway_vnet_panmanagement_subnet_cidr" {
    type        = string
    description = "CIDR block for the pan management subnet"
}

variable "gateway_vnet_pantrust_subnet_name" {
    type        = string
    description = "Name of the pan trust subnet"
}

variable "gateway_vnet_pantrust_subnet_cidr" {
    type        = string
    description = "CIDR block for the pan trust subnet"
}

variable "gateway_vnet_panuntrust_subnet_name" {
    type        = string
    description = "Name of the pan untrust subnet"
}

variable "gateway_vnet_panuntrust_subnet_cidr" {
    type        = string
    description = "CIDR block for the pan untrust subnet"
}

variable "gateway_vnet_gateway_subnet_name" {
    type        = string
    description = "Name of the gateway subnet"
}

variable "gateway_vnet_gateway_subnet_cidr" {
    type        = string
    description = "CIDR block for the gateway subnet"
}

variable "gateway_vnet_pancustom_subnet_name" {
    type        = string
    description = "Name of the pan custom subnet"
}

variable "gateway_vnet_pancustom_subnet_cidr" {
    type        = string
    description = "CIDR block for the pan custom subnet"
}

variable "gateway_vnet_pandev_subnet_name" {
    type        = string
    description = "Name of the pan dev subnet"
}

variable "gateway_vnet_pandev_subnet_cidr" {
    type        = string
    description = "CIDR block for the pan dev subnet"
}

