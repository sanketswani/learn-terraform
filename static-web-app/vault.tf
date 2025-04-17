data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "terraform_application_access" {
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "purge",
  ]
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