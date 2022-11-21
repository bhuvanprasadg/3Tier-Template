#CDN Profile
resource "azurerm_cdn_frontdoor_profile" "cdn" {
  name                = var.cdn_profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.cdn_sku_name

  tags = {
    environment = var.environment
  }
}

#CDN Endpoint
resource "azurerm_cdn_endpoint" "endpoint" {
  name                = var.cdn_endpoint_name
  origin_host_header  = var.primary_blob_host
  profile_name        = azurerm_cdn_frontdoor_profile.cdn.name
  resource_group_name = var.resource_group_name
  location            = var.location

  origin {
    name      = var.origin_name
    host_name = var.primary_blob_host
  }
  tags = {
    environment = var.environment
  }
}
