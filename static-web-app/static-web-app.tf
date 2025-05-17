resource "azurerm_static_web_app" "portfolio-static-web-app" {
  name                               = "stwapp-portfolio-prod"
  resource_group_name                = azurerm_resource_group.rg-static-web-app.name
  location                           = azurerm_resource_group.rg-static-web-app.location
  configuration_file_changes_enabled = true
  preview_environments_enabled       = true
  public_network_access_enabled      = true
  sku_tier                           = "Free"
  sku_size                           = "Free"
}

import {
  to = azurerm_static_web_app.portfolio-static-web-app_old
  id = "/subscriptions/72dc161b-6a20-403a-8338-e0ca13c9d086/resourceGroups/rg-portfolio-content/providers/Microsoft.Web/staticSites/my-portfolio"
}


resource "azurerm_static_web_app" "portfolio-static-web-app_old" {
  name                               = "my-portfolio"
  resource_group_name                = "rg-portfolio-content"
  location                           = "West Europe"
  configuration_file_changes_enabled = true
  preview_environments_enabled       = true
  public_network_access_enabled      = true
  sku_tier                           = "Free"
  sku_size                           = "Free"
}