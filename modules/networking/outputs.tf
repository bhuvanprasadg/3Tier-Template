output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "dbsubnet_id" {
  value = azurerm_subnet.db.id
}