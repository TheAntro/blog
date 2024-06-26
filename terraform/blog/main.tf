resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_static_web_app" "web_app" {
  name                = var.web_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_static_web_app_custom_domain" "web_app" {
  static_web_app_id = azurerm_static_web_app.web_app.id
  domain_name       = var.domain_name
  validation_type   = "cname-delegation"
}
