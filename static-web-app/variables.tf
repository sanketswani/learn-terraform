variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "oidc_request_token" {}
variable "oidc_request_url" {}
variable "key_vault_id" {
  description = "value of key vault id"
  type        = string
  default     = "/subscriptions/72dc161b-6a20-403a-8338-e0ca13c9d086/resourceGroups/rg-poc-cosmos-fun/providers/Microsoft.KeyVault/vaults/kv-my-test-1995"
}