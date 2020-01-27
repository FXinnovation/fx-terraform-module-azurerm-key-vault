locals {
  should_create_certificate = var.enabled && var.certificate_enabled
}


###
# Key Vault
###

resource "azurerm_key_vault" "this" {
  count                           = var.enabled ? 1 : 0
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.subnet_id_maps
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    var.tags,
  )
}

resource "azurerm_key_vault_access_policy" "this_policy" {
  count                   = var.enabled ? length(var.policies) : 0
  key_vault_id            = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  tenant_id               = lookup(element(var.policies, count.index), "tenant_id", null)
  object_id               = lookup(element(var.policies, count.index), "object_id", null)
  key_permissions         = lookup(element(var.policies, count.index), "key_permissions", null)
  secret_permissions      = lookup(element(var.policies, count.index), "secret_permissions", null)
  certificate_permissions = lookup(element(var.policies, count.index), "certificate_permissions", null)
}

resource "random_password" "this_password" {
  count       = var.enabled ? length(var.vault_secret_name) : 0
  length      = 16
  min_lower   = 3
  min_upper   = 3
  min_special = 3
  min_numeric = 3
}

resource "azurerm_key_vault_secret" "this_secret" {
  count        = var.enabled ? length(var.vault_secret_name) : 0
  name         = element(var.vault_secret_name, count.index)
  value        = element(var.value, count.index) != "" ? element(var.value, count.index) : random_password.this_password[count.index].result
  key_vault_id = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  depends_on   = [azurerm_key_vault.this, azurerm_key_vault_access_policy.this_policy]
  tags = merge(
    {
      "Terraform" = "true"
    },
    var.tags,
    var.vault_secret_tags,
  )
}

resource "azurerm_key_vault_certificate" "this_certificate" {
  count        = local.should_create_certificate ? 1 : 0
  name         = var.certificate_name
  key_vault_id = element(concat(azurerm_key_vault.this.*.id, [""]), 0)

  certificate_policy {
    issuer_parameters {
      name = var.issuer_name
    }
    key_properties {
      exportable = var.exportable
      key_size   = var.key_size
      key_type   = var.key_type
      reuse_key  = var.reuse_key
    }
    secret_properties {
      content_type = var.content_type
    }
    lifetime_action {
      action {
        action_type = var.action_type
      }
      trigger {
        days_before_expiry = var.days_before_expiry
      }
    }
  }
  tags = merge(
    {
      "Terraform" = "true"
    },
    var.tags,
    var.certificate_tags,
  )

}

resource "azurerm_key_vault_key" "this_key" {
  count        = var.enabled ? length(var.key_vault_keys) : 0
  name         = lookup(element(var.key_vault_keys, count.index), "name", null)
  key_vault_id = element(concat(azurerm_key_vault.this.*.id, [""]), 0)
  key_type     = lookup(element(var.key_vault_keys, count.index), "key_type", null)
  key_size     = lookup(element(var.key_vault_keys, count.index), "key_size", null)
  key_opts     = lookup(element(var.key_vault_keys, count.index), "key_opts", null)
  curve        = lookup(element(var.key_vault_keys, count.index), "curve", null)
  depends_on   = [azurerm_key_vault.this, azurerm_key_vault_access_policy.this_policy]
  tags = merge(
    {
      "Terraform" = "true"
    },
    var.tags,
    var.vault_key_tags,
  )
}
