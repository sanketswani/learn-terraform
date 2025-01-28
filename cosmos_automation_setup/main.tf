terraform {
  cloud {

    organization = "ApnaCompany"

    workspaces {
      name = "ws-api-based-sanket-002"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
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

variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "oidc_request_token" {}
variable "oidc_request_url" {}