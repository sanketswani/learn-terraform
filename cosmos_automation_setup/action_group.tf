resource "azurerm_monitor_action_group" "change_ru_action_group" {
  name                = "ChangeRuActionGroup"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "chngrus"

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