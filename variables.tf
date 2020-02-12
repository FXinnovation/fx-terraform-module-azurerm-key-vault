###
# General
###

variable "enabled" {
  description = "Enable or disable module"
  default     = true
}

variable "resource_group_name" {
  description = "Specifies name of the resource group in which the rsource will be created."
  type        = string
  default     = ""
}

variable "location" {
  description = "specifiies the loaction where the Key Vault will be created. changing this will force to created new resource."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource"
  default     = {}
}

###
# Key Vault
###

variable "key_vault_name" {
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "sku_name" {
  description = " The name of the SKU used for the Key Vault. Possible values are `standard` and `premium`."
  default     = "standard"
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure VM's are permitted to retrive certificate stored as secret from Key Vault."
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the Key Vault."
  default     = false
}

variable "ip_rules" {
  description = " One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "network_acls" {
  description = "One or more network acls associated to the Key Vault. Please check the terraform docs for the possible value `https://www.terraform.io/docs/providers/azurerm/r/key_vault_certificate.html`"
  default     = []
  type        = list(object({ bypass = string, default_action = string, ip_rules = list(string), virtual_network_subnet_ids = list(string) }))
}


variable "key_vault_tags" {
  description = "List of tags to which will be added to the Key Vault."
  default     = {}
}

###
# Key Vault access policy
###

variable "admin_policy_enabled" {
  description = "Boolean flag which describes whether to enable the default admin policy or not."
  default     = false
}

variable "policies" {
  description = "List of policies which will be created for the Key Vault. Changing this will force to create new policy to the Key Vault."
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
# Key Vault secret
###

variable "secret_enabled" {
  description = "Boolean flag which specify whether to create the secret in the key valut or not."
  default     = false
}

variable "key_vault_secrets" {
  description = "List of Key Valut secret names. Changing this will force to create new secret in the Key Vault."
  type        = list(string)
  default     = [""]
}

variable "key_vault_secret_tags" {
  description = "Tag that will be added to the Key Vault secret"
  default     = {}
}

variable "values" {
  description = "List of Key Vault secret that will cretaed. changing this will force to create new Key Vault secret."
  type        = list(string)
  default     = [""]
}

###
# Key Vault certificate
###

variable "certificate_enabled" {
  description = "Boolean flag which describes whether to  enable the Key Vault certificate or not."
  default     = false
}

variable "certificate_names" {
  description = "List of Key Vault certificate names. Changing will force to create new Key Vault certificate."
  type        = list(string)
  default     = []
}

variable "issuer_names" {
  description = "List of Certificate Issuer names. Possible values ( `Self`(for self-signed) or `unknown`(for a certificate issuing authority like Let's Encrypt and Azure direct supported one. )"
  type        = list(string)
  default     = []
}

variable "exportable" {
  description = "Boolean flag which define is this Certificate Exportable or not."
  type        = list(bool)
  default     = [false]
}

variable "reuse_key" {
  description = "Boolean flag which describes whether to use the existing key again or not"
  type        = list(bool)
  default     = [false]
}

variable "key_sizes" {
  description = "List of key sizes of the key used to create certificate. Possible values include `2048` and `4096`. Changing this forces a new resource to be created.  "
  type        = list(string)
  default     = [""]
}

variable "key_types" {
  description = "List of type of the key wich will be created such as `RSA`. changing this forces a new resourceto be created."
  type        = list(string)
  default     = [""]
}

variable "content_types" {
  description = "List of  content-type of the certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM."
  type        = list(string)
  default     = [""]
}

variable "action_types" {
  description = "List of type of action to be performed when the lifetime trigger is triggerec.possible values include `Autorenew` & ``EmailContacts. changing this forces a new resource to be created. "
  type        = list(string)
  default     = [""]
}

variable "days_before_expiry" {
  description = "List of number of days before the certificate expires that the action associated with this Trigger should run.changing this forces a new resource to be created."
  type        = list(number)
  default     = [30]
}

variable "certificate_tags" {
  description = "Tag that will be added to the certificate."
  default     = {}
}

###
# Key Vault keys
###

variable "key_vault_keys_enabled" {
  description = "Boolean flag which describes whether to enable to Key Vault keys or not."
  default     = false
}

variable "key_vault_keys" {
  description = "List of keys which will be created for the Key Vault. Changing this will force to create new key to the Key Vault."
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
  description = "Tags to add to the Key Vault_key"
  default     = {}
}
