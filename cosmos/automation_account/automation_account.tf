resource "azurerm_resource_group" "example" {
  name     = "rg-weu-nonprod-003"
  location = "West Europe"
  tags     = { "created-by" = "terraform", "createdFor" = "automation account" }
}