###
# locals
###

locals {
  should_create_certificate    = var.enabled && var.certificate_enabled
  should_create_secret         = var.enabled && var.secret_enabled
  should_create_admin_policy   = var.enabled && var.admin_policy_enabled
  should_create_key_vault_keys = var.enabled && var.key_vault_keys_enabled
}

###
# Key Vault
###

resource "azurerm_key_vault" "this" {
  count = var.enabled ? 1 : 0

  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  dynamic "network_acls" {
    for_each = var.network_acls

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }

  tags = merge(
    var.tags,
    var.key_vault_tags,
    {
      "Terraform" = "true"
    },
  )
}

###
# Key Vault default admin policy
###

resource "azurerm_key_vault_access_policy" "admin_policy" {
  count = local.should_create_admin_policy ? 1 : 0

  key_vault_id       = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  key_permissions    = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey", ]
  secret_permissions = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set", ]
  certificate_permissions = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge",
  "recover", "setissuers", "update", "backup", "restore", ]
}

###
# Key Vault access policy
###

resource "azurerm_key_vault_access_policy" "this_policy" {
  count = var.enabled ? length(var.policies) : 0

  key_vault_id            = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  tenant_id               = lookup(element(var.policies, count.index), "tenant_id", null)
  object_id               = lookup(element(var.policies, count.index), "object_id", null)
  key_permissions         = lookup(element(var.policies, count.index), "key_permissions", null)
  secret_permissions      = lookup(element(var.policies, count.index), "secret_permissions", null)
  certificate_permissions = lookup(element(var.policies, count.index), "certificate_permissions", null)
}

###
# Key Vault secret
###

resource "random_password" "this_password" {
  count = local.should_create_secret ? length(var.key_vault_secrets) : 0

  length      = 16
  min_lower   = 3
  min_upper   = 3
  min_special = 3
  min_numeric = 3
}

resource "azurerm_key_vault_secret" "this_secret" {
  count = local.should_create_secret ? length(var.key_vault_secrets) : 0

  name         = element(var.key_vault_secrets, count.index)
  value        = element(var.values, count.index) != "" ? element(var.values, count.index) : random_password.this_password[count.index].result
  key_vault_id = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  depends_on   = [azurerm_key_vault.this, azurerm_key_vault_access_policy.admin_policy, azurerm_key_vault_access_policy.this_policy]
  tags = merge(
    var.tags,
    var.key_vault_secret_tags,
    {
      "Terraform" = "true"
    },
  )
}

###
# Key Vault certificate
###

resource "azurerm_key_vault_certificate" "this_certificate" {
  count = local.should_create_certificate ? length(var.certificate_names) : 0

  name         = element(var.certificate_names, count.index)
  key_vault_id = element(concat(azurerm_key_vault.this.*.id, [""]), 0)

  certificate_policy {
    issuer_parameters {
      name = var.issuer_names[count.index]
    }
    key_properties {
      exportable = var.exportable[count.index]
      key_size   = var.key_sizes[count.index]
      key_type   = var.key_types[count.index]
      reuse_key  = var.reuse_key[count.index]
    }
    secret_properties {
      content_type = var.content_types[count.index]
    }
    lifetime_action {
      action {
        action_type = var.action_types[count.index]
      }
      trigger {
        days_before_expiry = var.days_before_expiry[count.index]
      }
    }
  }
  tags = merge(
    var.tags,
    var.certificate_tags,
    {
      "Terraform" = "true"
    },
  )
}

###
# Key Vault key
###

resource "azurerm_key_vault_key" "this_key" {
  count = local.should_create_key_vault_keys ? length(var.key_vault_keys) : 0

  name         = lookup(element(var.key_vault_keys, count.index), "name", null)
  key_vault_id = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  key_type     = lookup(element(var.key_vault_keys, count.index), "key_type", null)
  key_size     = lookup(element(var.key_vault_keys, count.index), "key_size", null)
  key_opts     = lookup(element(var.key_vault_keys, count.index), "key_opts", null)
  curve        = lookup(element(var.key_vault_keys, count.index), "curve", null)
  depends_on   = [azurerm_key_vault.this, azurerm_key_vault_access_policy.admin_policy, azurerm_key_vault_access_policy.this_policy]
  tags = merge(
    var.tags,
    var.key_vault_key_tags,
    {
      "Terraform" = "true"
    },
  )
}
