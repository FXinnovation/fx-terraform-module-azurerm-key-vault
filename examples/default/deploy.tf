module "resource_group_demo" {
  source   = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-azurerm-resource-group.git?ref=0.2.0"
  location = "francecentral"
  name     = "tftest-sa"
}

module "key_vault_demo" {
  source              = "../.."
  key_vault_name      = "fxtstkeyvault"
  location            = "francecentral"
  resource_group_name = module.resource_group_demo.name
  sku_name            = "standard"
  vault_secret_name   = ["foo"]
  value               = ["thisistestvalue"]
  certificate_enabled = false
  key_vault_keys      = []
  policies = [
    {
      tenant_id          = "${var.tenant_id}"
      object_id          = "${data.azurerm_client_config.current.object_id}"
      key_permissions    = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey", ]
      secret_permissions = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set", ]

      certificate_permissions = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge",
      "recover", "setissuers", "update", "backup", "restore", ]
    }
  ]
}
