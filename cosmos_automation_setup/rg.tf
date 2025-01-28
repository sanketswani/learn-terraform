resource "azurerm_resource_group" "example" {
  name     = "rg-new-weu-nonprod-002"
  location = "West Europe"
  tags     = { "created-by" = "terraform", "createdFor" = "Cosmos" }
}