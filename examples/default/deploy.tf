data "azurerm_client_config" "current" {}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azuread_group" "example" {
  name = "toto${random_string.this.result}"
}


resource "azurerm_resource_group" "example" {
  name     = "tftest-keyvault"
  location = "francecentral"
}

resource "azurerm_virtual_network" "example" {
  name                = "fxtoto${random_string.this.result}"
  address_space       = ["192.172.0.0/16"]
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "tftest${random_string.this.result}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "192.172.1.0/24"
  service_endpoints    = ["Microsoft.KeyVault"]
}

module "key_vault_demo" {
  source              = "../.."
  key_vault_name      = "fxtstkeyvault"
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "standard"
  network_acls = [
    {
      bypass                     = "AzureServices"
      default_action             = "Allow"
      ip_rules                   = ["192.172.1.10/32"]
      virtual_network_subnet_ids = ["${azurerm_subnet.example.id}"]
    }
  ]
  admin_policy_enabled = true
  policies = [
    {
      tenant_id          = "${var.tenant_id}"
      object_id          = "${azuread_group.example.id}"
      key_permissions    = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey", ]
      secret_permissions = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set", ]

      certificate_permissions = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge",
      "recover", "setissuers", "update", "backup", "restore", ]
    }
  ]

  key_vault_secrets      = ["foo"]
  values                 = ["thisistestvalue"]
  secret_enabled         = true
  certificate_enabled    = false
  key_vault_keys_enabled = false
}
