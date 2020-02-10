# terraform-module-azurerm-key-vault

## Usage
See `examples` folders for usage of this module.

## Limitation

- Any call to this module will create resources in a single resource group
- Only one network acl per keyvault is possible for now.
- Can on create access policy in default tenant

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| action\_types | The Type of action to be performed when the lifetime trigger is triggerec.possible values include `Autorenew` & `EmailContacts. changing this forces a new resource to be created.` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| certificate\_enabled | Boolean flag to enable the key vault certificate | `bool` | `false` | no |
| certificate\_names | Name of the key vault certificate. | `list(string)` | `[]` | no |
| certificate\_tags | Tag that will be added to the certificate. | `map` | `{}` | no |
| content\_types | The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| days\_before\_expiry | The number of days before the Certificate expires that the action associated with this Trigger should run. | `number` | `30` | no |
| enabled | Enable or disable module | `bool` | `true` | no |
| enabled\_for\_deployment | Boolean flag to specify whether Azure VM's are permitted to retrive certificate stored as secret from key vault. | `bool` | `false` | no |
| enabled\_for\_disk\_encryption | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| enabled\_for\_template\_deployment | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| exportable | Boolean flag to define is this Certificate Exportable | `bool` | `false` | no |
| ip\_rules | One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault. | `list(string)` | `[]` | no |
| issuer\_names | The name of the Certificate Issuer. Possible values ( `Self`(for self-signed) or `unknown`(for a certificate issuing authority like Let's Encrypt and Azure direct supported one. ) | `list(string)` | `[]` | no |
| key\_sizes | The size of the Key used in the Certificate | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| key\_types | The type of the key wich will be created such as `RSA`. changing this forces a new resourceto be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| key\_vault\_key\_tags | Tags to add to the key vault\_key | `map` | `{}` | no |
| key\_vault\_keys | Map of the key attributes. | <pre>list(object({<br>    name     = string<br>    key_type = string<br>    key_size = string<br>    key_opts = list(string)<br>    curve    = string<br>  }))</pre> | `[]` | no |
| key\_vault\_name | name of the Key vault created | `string` | `""` | no |
| key\_vault\_secrets | List of key valut secrets names. Changing this will force to create new secret in the key vault. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| key\_vault\_tags | List of tags to which will be added to the key vault. | `map` | `{}` | no |
| location | location of the load\_balancer | `string` | `""` | no |
| network\_acl | one or more network acls associated to the key vault. Please check the terraform docs for the possible value `https://www.terraform.io/docs/providers/azurerm/r/key_vault_certificate.html` | `list(object({ bypass = list(string), default_action = list(string), ip_rules = list(string), virtual_network_subnet_ids = list(string) }))` | `[]` | no |
| policies | List of policies that are created for this key vault. | <pre>list(object({<br>    tenant_id               = string<br>    object_id               = string<br>    key_permissions         = list(string)<br>    secret_permissions      = list(string)<br>    certificate_permissions = list(string)<br>  }))</pre> | `[]` | no |
| resource\_group\_name | Resource group where the vnet resides. | `string` | `""` | no |
| reuse\_key | Boolean flag to decide whether to use the existing key again or not | `bool` | `false` | no |
| secret\_enabled | Boolean flag to specify whether to create the secret in the key valut or not. | `bool` | `false` | no |
| sku\_name | Name of the SKU used for the key vault | `string` | `"standard"` | no |
| subnet\_id\_maps | One or more Subnet ID's which should be able to access this Key Vault. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| tags | Tags to add to the Load Balancer | `map` | `{}` | no |
| values | List of key valut secret that will cretaed. changing this will force to create new secret. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vault\_secret\_tags | Tag that will be added to the ker vault secret | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_vault\_certificate\_ids | Key vault certificate id |
| key\_vault\_ids | ID of the key vault |
| key\_vault\_key\_ids | n/a |
| key\_vault\_policy\_ids | n/a |
| key\_vault\_urls | URI of the key created |
| secret\_ids | n/a |
| thumbprint | Thumbprint of the key vault certificate |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
