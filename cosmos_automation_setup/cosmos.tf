# resource "azurerm_cosmosdb_account" "db" {
#   name                             = "cosmos-mongo-account-002"
#   location                         = azurerm_resource_group.example.location
#   resource_group_name              = azurerm_resource_group.example.name
#   offer_type                       = "Standard"
#   kind                             = "MongoDB"
#   free_tier_enabled                = true
#   multiple_write_locations_enabled = false
#   tags                             = { "CreatedBy" = "terraform" }
#   capabilities {
#     name = "EnableMongo"
#   }

#   consistency_policy {
#     consistency_level       = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }

#   geo_location {
#     location          = azurerm_resource_group.example.location
#     failover_priority = 0
#   }
# }

module "cosmos-db-account" {
  source           = "app.terraform.io/ApnaCompany/cosmos-db-account/azure"
  version          = "0.2.0"
  account_name     = "cosmos-mongo-account-002"
  resource_group   = azurerm_resource_group.example.name
  location         = azurerm_resource_group.example.location
  enable_free_tier = true
}

resource "azapi_resource" "mongodbDatabase" {
  type      = "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-10-15"
  parent_id = module.cosmos-db-account.id
  name      = "testDB"
  body = {
    properties = {
      options = {
      }
      resource = {
        id = "testDB"
      }
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

# resource "azapi_resource" "NewColl" {
#   type      = "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/collections@2024-12-01-preview"
#   name      = "myColl"
#   parent_id = azapi_resource.mongodbDatabase.id
#   # identity = {
#   #   type = "UserAssigned"
#   #   userAssignedIdentities = azurerm_user_assigned_identity.automation_account_identity.name
#   # }
#   location = azurerm_resource_group.example.location
#   tags = {
#     "createdBy" = "terraform"
#   }
#   body = {
#     properties = {
#       options = {
#         autoscaleSettings = {
#           maxThroughput = 1000
#         }
#       }
#       resource = {
#         createMode = "Default"
#         id         = "myColl"
#         indexes = [
#           {
#             key = {
#               keys = [
#                 "_id"
#               ]
#             }
#             options = {
#               unique = true
#             }
#           },
#           {
#             key = {
#               keys = [
#                 "_ts"
#               ]
#             }
#             options = {
#               unique             = false
#               expireAfterSeconds = 60
#             }
#           }
#         ]
#         shardKey = {
#           "_id" = "hashed"
#         }
#       }
#     }
#   }
# }

# resource "azapi_resource" "NewColl2" {
#   type      = "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/collections@2024-12-01-preview"
#   name      = "myColl2"
#   parent_id = azapi_resource.mongodbDatabase.id
#   location  = azurerm_resource_group.example.location
#   tags = {
#     "createdBy" = "terraform"
#   }
#   body = {
#     properties = {
#       options = {
#         autoscaleSettings = {
#           maxThroughput = 2000
#         }
#       }
#       resource = {
#         createMode = "Default"
#         id         = "myColl2"
#       }
#     }
#   }
# }

resource "azurerm_role_assignment" "identity1_on_cosmos" {
  scope = module.cosmos-db-account.id
  # scope                =  azurerm_cosmosdb_account.db.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.automation_account_identity.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_monitor_metric_alert" "monitor_rus_alert" {
  name                = "MonitorRUsAlert"
  resource_group_name = azurerm_resource_group.example.name
  scopes              = [module.cosmos-db-account.id]
  # scopes              = [azurerm_cosmosdb_account.db.id]
  description = "Action will be triggered when RU usage is greater than 50% for last hour"
  frequency   = "PT5M"
  severity    = 0
  window_size = "PT1H"
  criteria {
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    metric_name      = "NormalizedRUConsumption"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 50

    dimension {
      name     = "CollectionName"
      operator = "Include"
      values   = ["testColl"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.update_rus_action_group.id
  }
}