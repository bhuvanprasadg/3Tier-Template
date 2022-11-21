variable "resource_group_name" {}
variable "location" {}
variable "environment" {}
variable "vnet_id" {}
variable "dbsubnet_id" {}
variable "private_dns_zone_name" {default = "sampleprivatedns.postgres.database.azure.com"}
variable "dns_vnet_link_name" {default = "databasezonevnet.com"}
variable "db_server_name" {}
variable "db_server_admin_username" {}
variable "db_server_admin_password" {}
variable "storage_mb" {}
variable "sku_name" {}
variable "postgres_configuration_name" {default = "configurationforpostgres"}
variable "database_name" {}
variable "db_server_firewall_start_ip_address" {}
variable "db_server_firewall_end_ip_address" {}
variable "database_firewall_rule_name" {}