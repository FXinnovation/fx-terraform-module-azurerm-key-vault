resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "francecentral"
}

resource "azurerm_virtual_network" "example" {
  name                = "fxtoto"
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
  key_vault_name      = "fxtst${random_string.this.result}"
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "standard"
  key_vault_secrets   = ["foo"]
  values              = ["thisistestvalue"]
  secret_enabled      = true
  certificate_enabled = false
  key_vault_keys      = []
  policies            = []

  network_acl = [
    {
      bypass                     = "AzureServices"
      default_action             = "Allow"
      ip_rules                   = ["192.172.1.10"]
      virtual_network_subnet_ids = ["${azurerm_subnet.example.id}"]
    }
  ]
}
