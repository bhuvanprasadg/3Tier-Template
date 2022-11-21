resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet" {
  name                  = var.dns_vnet_link_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
}

resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = var.db_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "14"
  delegated_subnet_id    = var.dbsubnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.dns_zone.id
  administrator_login    = var.db_server_admin_username
  administrator_password = var.db_server_admin_password
  storage_mb             = var.storage_mb
  sku_name               = var.sku_name

  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_vnet]
}

resource "azurerm_postgresql_flexible_server_configuration" "postgres_server_config" {
  name      = var.postgres_configuration_name
  server_id = azurerm_postgresql_flexible_server.psql.id
  value     = "CUBE,CITEXT,BTREE_GIST"
}

resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.psql.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall" {
  name             = var.database_firewall_rule_name
  server_id        = azurerm_postgresql_flexible_server.psql.id
  start_ip_address = var.db_server_firewall_start_ip_address
  end_ip_address   = var.db_server_firewall_end_ip_address
}