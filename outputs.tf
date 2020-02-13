###
# Key Vault
###

output "key_vault_ids" {
  description = "IDs of the Key vVult"
  value       = compact(concat(azurerm_key_vault.this.*.id, [""]))
}

output "key_vault_urls" {
  description = "URIs of the Key Vault created, used for performing operationson keys and secrets."
  value       = compact(concat(azurerm_key_vault.this.*.vault_uri, [""]))
}

###
# Key Vault access policy
###

output "key_vault_admin_policy_ids" {
  description = "IDs of the default admins policy."
  value       = compact(concat(azurerm_key_vault_access_policy.admin_policy.*.id, [""]))
}

output "key_vault_policy_ids" {
  description = "IDs of the Key Vault access policies."
  value       = compact(concat(azurerm_key_vault_access_policy.this_policy.*.id, [""]))
}

###
# Key Vault secret
###

output "secret_ids" {
  description = "IDs of the Key Vault secrets. "
  value       = compact(concat(azurerm_key_vault_secret.this_secret.*.id, [""]))
}

###
# Key Vault certificate
###

output "key_vault_certificate_ids" {
  description = "IDs of the Key vault certificates."
  value       = compact(concat(azurerm_key_vault_certificate.this_certificate.*.id, [""]))
}

output "thumbprint" {
  description = "Thumbprints of the Key Vault certificates."
  value       = compact(concat(azurerm_key_vault_certificate.this_certificate.*.thumbprint, [""]))
}

###
# Key Vault key
###

output "key_vault_key_ids" {
  description = "IDs of the Key Vault keys."
  value       = compact(concat(azurerm_key_vault_key.this_key.*.id, [""]))
}
