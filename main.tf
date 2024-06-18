provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "client_secret" {}