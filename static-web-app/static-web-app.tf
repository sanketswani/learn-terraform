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