module "resource-group" {
  source              = "../modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment
}

module "networking" {
  source                    = "../modules/networking"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  environment               = var.environment
  name                      = var.virtualnetwork_name
  vnet_address_space        = var.vnet_address_space
  webnsg_name               = var.webnsg_name
  web_nsg_ports             = var.web_nsg_ports
  web_nsg_port_name         = var.web_nsg_port_name
  appnsg_name               = var.appnsg_name
  app_nsg_ports             = var.app_nsg_ports
  app_nsg_port_name         = var.app_nsg_port_name
  dbnsg_name                = var.dbnsg_name
  db_nsg_ports              = var.db_nsg_ports
  db_nsg_port_name          = var.db_nsg_port_name
  web_subnet_address_prefix = var.web_subnet_address_prefix
  web_subnet_name           = var.web_subnet_name
  app_subnet_address_prefix = var.app_subnet_address_prefix
  app_subnet_name           = var.app_subnet_name
  db_subnet_address_prefix  = var.db_subnet_address_prefix
  db_subnet_name            = var.db_subnet_name
}

module "database" {
  source                              = "../modules/database"
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  environment                         = var.environment
  vnet_id                             = module.networking.vnet_id
  dbsubnet_id                         = module.networking.dbsubnet_id
  db_server_name                      = var.db_server_name
  db_server_admin_username            = var.db_server_admin_username
  db_server_admin_password            = var.db_server_admin_password
  storage_mb                          = var.storage_mb
  sku_name                            = var.sku_name
  database_name                       = var.database_name
  database_firewall_rule_name         = var.database_firewall_rule_name
  db_server_firewall_start_ip_address = var.db_server_firewall_start_ip_address
  db_server_firewall_end_ip_address   = var.db_server_firewall_end_ip_address
}

module "storage" {
  source                   = "../modules/storage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  environment              = var.environment
  storage_account_name     = var.storage_account_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  storage_container_name   = var.storage_container_name
  container_access_type    = var.container_access_type
  blob_name                = var.blob_name
  blob_type                = var.blob_type
  blob_source_location     = var.blob_source_location
  blob_access_tier         = var.blob_access_tier
}

module "cdn" {
  source              = "../modules/cdn"
  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment
  cdn_profile_name    = var.cdn_profile_name
  cdn_sku_name        = var.cdn_sku_name
  cdn_endpoint_name   = var.cdn_endpoint_name
  primary_blob_host    = module.storage.primary_blob_host
}
