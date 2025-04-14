resource "azurerm_resource_group" "rg-static-web-app" {
  name     = "rg-portfolio-prod"
  location = "West Europe"
  tags     = { "created-by" = "terraform", "createdFor" = "Static Web App" }
}