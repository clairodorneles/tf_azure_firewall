## random string

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

## resource group

resource "azurerm_resource_group" "rg-fw" {
  name                     = upper(var.rgName)
  location                 = var.location
  tags                     = var.tags

}

## storage account

resource "azurerm_storage_account" "storageAccount-fw" {
  name                      = lower(replace(var.storageAccount_name, "/[[:^alnum:]]/", ""))
  resource_group_name       = azurerm_resource_group.rg-fw.name
  location                  = azurerm_resource_group.rg-fw.location
  account_tier              = "Standard"
  access_tier                = var.storageAccount_AccessTier
  account_replication_type  = "LRS"
  tags                      = var.tags
  depends_on                = [azurerm_resource_group.rg-fw]
}

## virtual network

resource "azurerm_virtual_network" "vnet-fw" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg-fw.name
  location            = azurerm_resource_group.rg-fw.location
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.rg-fw.name
  virtual_network_name = azurerm_virtual_network.vnet-fw.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
  depends_on           = [azurerm_virtual_network.vnet-fw]
}

##
## public ip

resource "azurerm_public_ip" "pip-fw" {
  name                = var.pip_name
  location            = azurerm_resource_group.rg-fw.location
  resource_group_name = azurerm_resource_group.rg-fw.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

##
## azure firewall

data "azurerm_subnet" "azfw-subnet" {
  name                  = "AzureFirewallSubnet"
  resource_group_name   = azurerm_resource_group.rg-fw.name
  virtual_network_name  = azurerm_virtual_network.vnet-fw.name
}

resource "azurerm_firewall" "azfw" {
  name                = var.afw_name
  location            = azurerm_resource_group.rg-fw.location
  resource_group_name = azurerm_resource_group.rg-fw.name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.azfw-subnet.id
    public_ip_address_id = azurerm_public_ip.pip-fw.id
  }
}

##