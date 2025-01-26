resource "azurerm_cosmosdb_account" "db" {
  name                             = "cosmos-new-account-002"
  location                         = azurerm_resource_group.example.location
  resource_group_name              = azurerm_resource_group.example.name
  offer_type                       = "Standard"
  kind                             = "MongoDB"
  free_tier_enabled                = true
  multiple_write_locations_enabled = false
  tags                             = { "CreatedBy" = "terraform" }
  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = azurerm_resource_group.example.location
    failover_priority = 0
  }



}