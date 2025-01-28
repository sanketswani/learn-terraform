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

data "local_file" "runbook_file" {
  filename = "${path.module}/increase-rus.ps1"
}

resource "azurerm_automation_runbook" "example" {
  name                    = "Update_RUs"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.automation_account.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This run book will manipulate RUs based on user input"
  runbook_type            = "PowerShell"

  content = data.local_file.runbook_file.content
}