module "cosmos-db-account" {
  source         = "app.terraform.io/ApnaCompany/cosmos-db-account/azure"
  version        = "0.1.0"
  account_name   = "cosmos-account-for-mongo-002"
  resource_group = azurerm_resource_group.example.name
  location       = azurerm_resource_group.example.location
}