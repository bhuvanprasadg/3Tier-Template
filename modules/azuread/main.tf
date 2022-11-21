# Retrieve domain information
data "azuread_domains" "ad_domains" {
  only_initial = true
}

# Create an application
resource "azuread_application" "ad_app_creation" {
  name = var.adapp_name
}

# Create a service principal
resource "azuread_service_principal" "ad_service_principal" {
  application_id = azuread_application.ad_app_creation.application_id
}

# Create a user
resource "azuread_user" "ad-user" {
  user_principal_name = "user@${data.azuread_domains.ad_domains.domains.0.domain_name}"
  display_name        = var.ad_username
  password            = var.ad_userpswd
}