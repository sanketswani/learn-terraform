resource "azurerm_automation_account" "automation_account" {
  name                = "automation-account-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.automation_account_identity.id]
  }
  tags = { "CreatedBy" = "terraform" }
}