resource "azurerm_cdn_frontdoor_profile" "cdn" {
  name                = var.cdn_profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.cdn_sku_name

  tags = {
    environment = var.environment
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = var.cdn_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn.id

  tags = {
    environment = var.environment
  }
}
