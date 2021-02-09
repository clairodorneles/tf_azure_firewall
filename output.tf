output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet-fw.id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet-fw.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet-fw.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet-fw.address_space
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newl vNet"
  value       = azurerm_subnet.subnet.*.id
}

output "storageAccount_id" {
  description = "The id of the newly created Stg Account"
  value       = azurerm_storage_account.storageAccount-fw.id
}

output "storageAccount_name" {
  description = "The name of the newly created Stg Account"
  value       = azurerm_storage_account.storageAccount-fw.name
}

output "storageAccount_location" {
  description = "The Location of the newly created Stg Account"
  value       = azurerm_storage_account.storageAccount-fw.location
}