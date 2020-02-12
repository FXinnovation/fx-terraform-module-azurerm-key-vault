output "key_vault_ids" {
  value = module.key_vault_demo.key_vault_ids
}

output "key_vault_admin_policy_id" {
  value = module.key_vault_demo.key_vault_admin_policy
}

output "key_vault_uris" {
  value = module.key_vault_demo.key_vault_urls
}
