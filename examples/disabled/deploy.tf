module "resource_group_demo" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-azurerm-resource-group.git?ref=0.2.0"

  enabled  = false
  location = "francecentral"
  name     = "tftest-sa"
}

module "key_vault_demo" {
  source = "../.."

  enabled = false

  key_vault_name      = "tftest"
  resource_group_name = module.resource_group_demo.name
  location            = "francecentral"
  sku_name            = "standard"
  certificate_enabled = false
  policies            = []
}
