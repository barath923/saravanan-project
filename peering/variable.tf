#HUB VARIABLES

variable "hub_resource_group_name" {
  description = "Name of the Hub resource group"
  type        = string
}

variable "hub_vnet_id" {
  description = "Resource ID of the Hub Virtual Network"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the Hub Virtual Network"
  type        = string
}

variable "hub_location" {
  description = "location for hub resource"
  type        = string
}

variable "hub_subnet_mgmt_id" {
  description = "managementsubnet for hub resource"
  type        = string
}

variable "hub_subnet_shared_id" {
  description = "sharedsubnet for hub resource"
  type        = string
}

variable "hub_subnet_gateway_id" {
  description = "gatewaysubnet for hub resource"
  type        = string
}

#GATEWAY VARIABLES
variable "gateway_resource_group_name" {
  description = "Name of the Gateway resource group"
  type        = string
}

variable "gateway_vnet_id" {
  description = "Resource ID of the Gateway Virtual Network"
  type        = string
}

variable "gateway_vnet_name" {
  description = "Name of the Gateway Virtual Network"
  type        = string
}

variable "gateway_location" {
  type       = string
}

variable "pan_mgmt_subnet_id" {
  description = "Subnet ID for PAN management interface"
  type        = string
}

variable "pan_trust_subnet_id" {
  description = "Subnet ID for PAN trust interface"
  type        = string
}

variable "pan_untrust_subnet_id" {
  description = "Subnet ID for PAN untrust interface"
  type        = string
}

variable "pan_gateway_subnet_id" {
  description = "Subnet ID for PAN gateway subnet"
  type        = string
}

variable "pan_custom_subnet_id" {
  description = "Subnet ID for PAN custom subnet"
  type        = string
}

variable "pan_dev_subnet_id" {
  description = "Subnet ID for PAN dev subnet"
  type        = string
}

#VELOCITY VARIABLES
variable "velocity_resource_group_name" {
  description = "Name of the Velocity resource group"
  type        = string
}

variable "velocity_vnet_id" {
  description = "Resource ID of the Velocity Virtual Network"
  type        = string
}

variable "velocity_vnet_name" {
  description = "name for vlocity vnet"
  type = string
}

variable "velocity_location" {
  type        = string
}

variable "velocity_management_subnet_id" {
  description = "Subnet ID for Velocity management subnet"
  type        = string
}

variable "velocity_subnet_one_id" {
  description = "Subnet ID for Velocity subnet one"
  type        = string
}


#CLINICAL VARIABLES
variable "clinical_resource_group_name" {
  description = "Name of the Clinical resource group"
  type        = string
}

variable "clinical_vnet_id" {
  description = "Resource ID of the Clinical Virtual Network"
  type        = string
}

variable "clinical_vnet_name" {
  description = "Name of the Clinical Virtual Network"
  type        = string
}

variable "clinical_location" {
  type        = string
}

variable "clinical_management_subnet_id" {
  description = "Subnet ID for Clinical management subnet"
  type        = string
}

variable "clinical_subnet_one_id" {
  description = "Subnet ID for Clinical subnet one"
  type        = string
}

variable "clinical_subnet_two_id" {
  description = "Subnet ID for Clinical subnet two"
  type        = string
}

#NON CLINICAL VARIABLES
variable "non_clinical_resource_group_name" {
  description = "Name of the Non-Clinical resource group"
  type        = string
}

variable "non_clinical_vnet_id" {
  description = "Resource ID of the Non-Clinical Virtual Network"
  type        = string
}

variable "non_clinical_vnet_name" {
  description = "Name of the Non-Clinical Virtual Network"
  type        = string
}

variable "non_clinical_location" {
  type        = string
}

variable "non_clinical_management_subnet_id" {
  description = "Subnet ID for Non-Clinical management subnet"
  type        = string
}

variable "non_clinical_subnet_one_id" {
  description = "Subnet ID for Non-Clinical subnet one"
  type        = string
}

variable "non_clinical_subnet_two_id" {
  description = "Subnet ID for Non-Clinical subnet two"
  type        = string
}