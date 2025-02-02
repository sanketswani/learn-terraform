module "cosmos-db-account" {
  source       = "app.terraform.io/ApnaCompany/cosmos-db-account/azure"
  version      = "0.1.0"
  account_name = "cos"
  resource_group = "rg-new-weu-nonprod-002"
  location = "West Europe"
}