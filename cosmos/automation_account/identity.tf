resource "azurerm_user_assigned_identity" "automation_account" {
  resource_group_name = azurerm_resource_group.example.name
  name                = "identity1"
  location            = azurerm_resource_group.example.location
}