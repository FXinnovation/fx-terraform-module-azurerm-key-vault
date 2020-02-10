data "azurerm_client_config" "current" {}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

module "resource_group_demo" {
  source   = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-azurerm-resource-group.git?ref=0.2.0"
  location = "francecentral"
  name     = "tftest${random_string.this.result}"
}

resource "azurerm_virtual_network" "example" {
  name                = "fxtoto"
  address_space       = ["10.0.0.0/16"]
  location            = "francecentral"
  resource_group_name = module.resource_group_demo.name
}

resource "azurerm_subnet" "example" {
  name                 = "tftest${random_string.this.result}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.0.0/24"
}

module "key_vault_demo" {
  source              = "../.."
  key_vault_name      = "fxtst${random_string.this.result}"
  location            = "francecentral"
  resource_group_name = module.resource_group_demo.name
  sku_name            = "standard"
  key_vault_secrets   = ["foo"]
  values              = ["thisistestvalue"]
  secret_enabled      = true
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

  network_acl = [
    {
      bypass                     = ["AzureServices"]
      default_action             = ["Allow"]
      ip_rules                   = ["10.0.1.16/24"]
      virtual_network_subnet_ids = ["${azurerm_subnet.example.id}"]
    }
  ]
}
