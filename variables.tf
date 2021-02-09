## global vars
variable "tags" {
  description = "Tags"
  type        = map(string)
}

variable "location" {
  description = "Location where resources will be deploy"
  type        = "string"
}


##
## rg vars
variable "rgName" {
  description = "Name of the resourceGroup"
  type        = "string"
}


##
## Stg VARS

variable "storageAccount_name" {
  description = "Name of the stgaccount"
  type        = string
}


variable "storageAccount_AccessTier" {
  description = "Name of the vnet to create"
  type        = string
  default     = "Hot"
}

##
## vnet vars
variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "vnet-default"
}


variable "vnet_address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.250.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "vnet_dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.250.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet_prd", "AzureFirewallSubnet"]
}

##
## pip vars 
variable "pip_name" {
  description = "The name of PIP"
  type        = string
}
##

## azure firewall
##
variable "afw_name" {
  description = "The name of AFW"
  type        = string
}



