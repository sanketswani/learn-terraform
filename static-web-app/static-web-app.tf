resource "azurerm_static_web_app" "portfolio-static-web-app" {
  name                               = "stwapp-portfolio-prod"
  resource_group_name                = azurerm_resource_group.rg-static-web-app.name
  location                           = azurerm_resource_group.rg-static-web-app.location
  configuration_file_changes_enabled = true
  preview_environments_enabled       = true
  public_network_access_enabled      = true
  sku_tier                           = Free
  sku_size                           = Free
}

resource "azurerm_key_vault_secret" "static-web-app-api-key" {
  name         = "static-web-app-api-key"
  value        = azurerm_static_web_app.portfolio-static-web-app.api_key
  key_vault_id = var.key_vault_id
  tags = {
    environment = "production"
    project     = "portfolio"
  }
}