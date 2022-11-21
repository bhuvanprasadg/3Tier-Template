resource "azurerm_network_security_group" "webnsg" {
  name                = var.webnsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = var.web_nsg_ports[0]
    direction                  = "Inbound"
    name                       = var.web_nsg_port_name[0]
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = var.web_nsg_ports[1]
    direction                  = "Inbound"
    name                       = var.web_nsg_port_name[1]
    priority                   = 150
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_network_security_group" "appnsg" {
  name                = var.appnsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = var.app_nsg_ports[0]
    direction                  = "Inbound"
    name                       = var.app_nsg_port_name[0]
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = var.app_nsg_ports[1]
    direction                  = "Inbound"
    name                       = var.app_nsg_port_name[1]
    priority                   = 150
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_network_security_group" "dbnsg" {
  name                = var.dbnsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = var.db_nsg_ports[0]
    direction                  = "Inbound"
    name                       = var.db_nsg_port_name[0]
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = var.db_nsg_ports[1]
    direction                  = "Inbound"
    name                       = var.db_nsg_port_name[1]
    priority                   = 150
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtualnetwork_name
  address_space       = var.vnet_address_space
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_subnet" "web" {
  name                 = var.web_subnet_name
  address_prefixes     = var.web_subnet_address_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "app" {
  name                 = var.app_subnet_name
  address_prefixes     = var.app_subnet_address_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "db" {
  name                 = var.db_subnet_name
  address_prefixes     = var.db_subnet_address_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "webnsg" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.webnsg.id
}

resource "azurerm_subnet_network_security_group_association" "appnsg" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.appnsg.id
}

resource "azurerm_subnet_network_security_group_association" "dbnsg" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.dbnsg.id
}