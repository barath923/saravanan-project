#RESOURCE GROUP AND LOCATION DETAILS
variable "hub_resource_group_name" {
  description = "Name of the resource group for the hub resources"
  type        = string
}

variable "hub_location" {
    description = "Azure region for the hub resources"
    type        = string
}   


#VNET DETAILS
variable "hub_vnet_name" {
  description = "The name of the virtual network for the hub."
  type        = string
}

variable "hub_vnet_cidr" {
    description = "CIDR block for the hub virtual network"
    type        = string
}

#SUBNET DETAILS
variable "hub_vnet_management_subnet_name" {
  description = "The name of the management subnet for the hub virtual network."
  type        = string
}

variable "hub_vnet_management_subnet_cidr" {
  description = "The CIDR block for the management subnet of the hub virtual network."
  type        = string
}

variable "hub_vnet_shared_subnet_name" {
  description = "The name of the shared services subnet for the hub virtual network."
  type        = string
}

variable "hub_vnet_shared_subnet_cidr" {
  description = "The CIDR block for the shared services subnet of the hub virtual network."
  type        = string
} 

variable "hub_vnet_gateway_subnet_name" {
  description = "The name for the gateway services subnet of the hub virtual network."
  type        = string
}

variable "hub_vnet_gateway_subnet_cidr" {
  description = "The CIDR block for the gateway services subnet of the hub virtual network."
  type        = string
}


#NAT GATEWAY DETAILS
variable "hub_nat_gateway_name" {
  description = "The name of the NAT gateway for the hub virtual network."
  type        = string
}

variable "hub_nat_public_ip_name" {
  description = "The name of the public IP for the NAT gateway in the hub virtual network."
  type        = string
}

variable "hub_nat_idle_timeout" {
  description = "The idle timeout in minutes for the NAT gateway in the hub virtual network."
  type        = number
  default     = 10
}

variable "hub_nat_sku_name" {
  description = "The SKU name for the NAT gateway in the hub virtual network."
  type        = string
  default     = "Standard"
}


