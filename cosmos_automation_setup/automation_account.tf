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

resource "azurerm_automation_runbook" "update_rus_runbook" {
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

resource "azurerm_automation_webhook" "update_rus_runbook_webhook" {
  name                    = "Update_RUs_webhook"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.automation_account.name
  expiry_time             = "2034-12-31T00:00:00Z"
  runbook_name            = azurerm_automation_runbook.update_rus_runbook.name
}

resource "azurerm_monitor_action_group" "update_rus_action_group" {
  name                = "UpdateRuActionGroup"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "updtrus"

  automation_runbook_receiver {
    name                    = "update_ru_receiver"
    automation_account_id   = azurerm_automation_account.automation_account.id
    runbook_name            = azurerm_automation_runbook.update_rus_runbook.name
    webhook_resource_id     = azurerm_automation_webhook.update_rus_runbook_webhook.id
    service_uri             = azurerm_automation_webhook.update_rus_runbook_webhook.uri
    is_global_runbook       = false
    use_common_alert_schema = false
  }
}