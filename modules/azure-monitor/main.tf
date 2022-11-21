resource "azurerm_logz_monitor" "az_monitor" {
  name                = var.az_monitor_name
  resource_group_name = var.resource_group_name
  location            = var.location
#   plan {
#     billing_cycle  = "MONTHLY"
#     effective_date = "2022-06-06T00:00:00Z"
#     plan_id        = "100gb14days"
#     usage_type     = "COMMITTED"
#   }

  plan {
    billing_cycle  = var.billing_cycle
    effective_date = var.effective_date
    plan_id        = var.plan_id
    usage_type     = var.usage_type
  }

  user {
    email        = var.user_email
    first_name   = var.first_name_monitor
    last_name    = var.last_name_monitor
    phone_number = var.phone_number
  }
}