###
# General
###

variable "enabled" {
  description = "Enable or disable module"
  default     = true
}

variable "resource_group_name" {
  description = "Resource group where the vnet resides."
  type        = string
  default     = ""
}

variable "location" {
  description = "location of the load_balancer"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to add to the Load Balancer"
  default     = {}
}

###
# key vault
###

variable "key_vault_name" {
  description = "name of the Key vault created"
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "Name of the SKU used for the key vault"
  default     = "standard"
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure VM's are permitted to retrive certificate stored as secret from key vault."
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = false
}

variable "ip_rules" {
  description = " One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "subnet_id_maps" {
  description = "One or more Subnet ID's which should be able to access this Key Vault."
  type        = list(string)
  default     = [""]
}

variable "network_acl" {
  description = "one or more network acls associated to the key vault. Please check the terraform docs for the possible value `https://www.terraform.io/docs/providers/azurerm/r/key_vault_certificate.html`"
  default     = []
  type        = list(object({ bypass = list(string), default_action = list(string), ip_rules = list(string), virtual_network_subnet_ids = list(string) }))
}


variable "key_vault_tags" {
  description = "List of tags to which will be added to the key vault."
  default     = {}
}

###
# key vault access policy
###

variable "policies" {
  description = "List of policies that are created for this key vault."
  type = list(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))
  default = []
}

###
# key vault secret
###

variable "secret_enabled" {
  description = "Boolean flag to specify whether to create the secret in the key valut or not."
  default     = false
}

variable "key_vault_secrets" {
  description = "List of key valut secrets names. Changing this will force to create new secret in the key vault."
  type        = list(string)
  default     = [""]
}

variable "vault_secret_tags" {
  description = "Tag that will be added to the ker vault secret"
  default     = {}
}

variable "values" {
  description = "List of key valut secret that will cretaed. changing this will force to create new secret."
  type        = list(string)
  default     = [""]
}

###
# key vault certificate
###

variable "certificate_enabled" {
  description = "Boolean flag to enable the key vault certificate"
  default     = false
}

variable "certificate_names" {
  description = "Name of the key vault certificate."
  type        = list(string)
  default     = []
}

variable "issuer_names" {
  description = "The name of the Certificate Issuer. Possible values ( `Self`(for self-signed) or `unknown`(for a certificate issuing authority like Let's Encrypt and Azure direct supported one. )"
  type        = list(string)
  default     = []
}

variable "exportable" {
  description = "Boolean flag to define is this Certificate Exportable"
  default     = false
}

variable "reuse_key" {
  description = "Boolean flag to decide whether to use the existing key again or not"
  default     = false
}

variable "key_sizes" {
  description = "The size of the Key used in the Certificate"
  type        = list(string)
  default     = [""]
}

variable "key_types" {
  description = "The type of the key wich will be created such as `RSA`. changing this forces a new resourceto be created."
  type        = list(string)
  default     = [""]
}

variable "content_types" {
  description = "The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM."
  type        = list(string)
  default     = [""]
}

variable "action_types" {
  description = "The Type of action to be performed when the lifetime trigger is triggerec.possible values include `Autorenew` & ``EmailContacts. changing this forces a new resource to be created. "
  type        = list(string)
  default     = [""]
}

variable "days_before_expiry" {
  description = "The number of days before the Certificate expires that the action associated with this Trigger should run."
  default     = 30
}

variable "certificate_tags" {
  description = "Tag that will be added to the certificate."
  default     = {}
}

###
# key vault keys
###

variable "key_vault_keys" {
  description = "Map of the key attributes."
  type = list(object({
    name     = string
    key_type = string
    key_size = string
    key_opts = list(string)
    curve    = string
  }))
  default = []
}

variable "key_vault_key_tags" {
  description = "Tags to add to the key vault_key"
  default     = {}
}
