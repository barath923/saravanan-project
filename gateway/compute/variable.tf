variable "gateway_resource_group_name" {
  description = "Resource group where PAN VM and related resources will be created"
  type        = string
}

variable "gateway_location" {
  description = "Azure region for PAN VM resources"
  type        = string
}

variable "pan_mgmt_subnet_id" {
  description = "Subnet ID for Palo Alto management interface"
  type        = string
}

variable "pan_trust_subnet_id" {
  description = "Subnet ID for Palo Alto trust interface"
  type        = string
}

variable "pan_untrust_subnet_id" {
  description = "Subnet ID for Palo Alto untrust interface"
  type        = string
}

variable "gateway_subnet_id" {
  description = "GatewaySubnet ID (VPN / ExpressRoute)"
  type        = string
}

variable "pan_custom_subnet_id" {
  description = "Custom subnet ID for additional PAN workloads"
  type        = string
}

variable "pan_dev_subnet_id" {
  description = "Dev subnet ID for testing or non-prod PAN use"
  type        = string
}


# VM configuration variables
variable "vm_size" {
  description = "Size of the Palo Alto VM-Series instance"
  type        = string
  default     = "Standard_D8s_v4"
}

variable "admin_username" {
  description = "Admin username for Palo Alto VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for Palo Alto VM"
  type        = string
  default     = "panvm@12345#"
}