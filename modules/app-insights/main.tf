resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                = var.analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.analytics_sku
  retention_in_days   = var.retention_in_days
}

resource "azurerm_application_insights" "app_insights" {
  insight_name        = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.analytics_workspace.id
  application_type    = var.application_type

#   tags  = {
#     app_insights = var.app
#   }
}