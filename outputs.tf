###
# key vault
###

output "key_vault_ids" {
  description = "ID of the key vault"
  value       = azurerm_key_vault.this.*.id
}

output "key_vault_urls" {
  description = "URI of the key created"
  value       = azurerm_key_vault.this.*.vault_uri
}

###
# key vault access policy
###

output "key_vault_policy_ids" {
  value = azurerm_key_vault_access_policy.this_policy.*.id
}

###
# key vault secret
###

output "secret_ids" {
  value = azurerm_key_vault_secret.this_secret.*.id
}

###
# key vault certificate
###

output "key_vault_certificate_ids" {
  description = "Key vault Certificate ID"
  value       = azurerm_key_vault_certificate.this_certificate.*.id
}

output "thumbprint" {
  description = "Thumbprint of the Key Vault Certificate"
  value       = azurerm_key_vault_certificate.this_certificate.*.thumbprint
}

###
# key vault key
###

output "key_vault_key_ids" {
  value = azurerm_key_vault_key.this_key.*.id
}
