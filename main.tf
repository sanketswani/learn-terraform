terraform {
  cloud {

    organization = "ApnaCompany"

    workspaces {
      name = "ws-api-based-sanket-002"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id    = var.subscription_id
  client_id          = var.client_id
  tenant_id          = var.tenant_id
  use_oidc           = true
  oidc_request_token = var.oidc_request_token
  oidc_request_url   = var.oidc_request_url
}

resource "azurerm_resource_group" "example" {
  name     = "rg-new-weu-nonprod-002"
  location = "West Europe"
}

variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "client_secret" {}
variable "oidc_request_token" {}
variable "oidc_request_url" {}