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
| action\_type | The Type of action to be performed when the lifetime trigger is triggerec. | `string` | `""` | no |
| certificate\_enabled | Boolean flag to enable the key vault certificate | `bool` | `false` | no |
| certificate\_name | Name of the key vault certificate. | `string` | `""` | no |
| certificate\_tags | Tag that will be added to the certificate. | `map` | `{}` | no |
| content\_type | The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. | `string` | `""` | no |
| days\_before\_expiry | The number of days before the Certificate expires that the action associated with this Trigger should run. | `number` | `30` | no |
| enabled | Enable or disable module | `bool` | `true` | no |
| enabled\_for\_deployment | Boolean flag to specify whether Azure VM's are permitted to retrive certificate stored as secret from key vault. | `bool` | `false` | no |
| enabled\_for\_disk\_encryption | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| enabled\_for\_template\_deployment | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| exportable | Boolean flag to define is this Certificate Exportable | `bool` | `false` | no |
| ip\_rules | One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault. | `list(string)` | n/a | yes |
| issuer\_name | The name of the Certificate Issuer. Possible values ( `Self`(for self-signed) or `unknown`(for a certificate issuing authority like Let's Encrypt and Azure direct supported one. ) | `string` | `""` | no |
| key\_size | The size of the Key used in the Certificate | `number` | `2048` | no |
| key\_type | Specifies the Type of Key. | `string` | `""` | no |
| key\_vault\_keys | Map of the key attributes. | <pre>list(object({<br>    name     = string<br>    key_type = string<br>    key_size = string<br>    key_opts = list(string)<br>    curve    = string<br>  }))<br></pre> | `[]` | no |
| key\_vault\_name | name of the Key vault created | `string` | n/a | yes |
| location | location of the load\_balancer | `string` | n/a | yes |
| policies | List of policies that are created for this key vault. | <pre>list(object({<br>    tenant_id               = string<br>    object_id               = string<br>    key_permissions         = list(string)<br>    secret_permissions      = list(string)<br>    certificate_permissions = list(string)<br>    storage_permissions     = list(string)<br>  }))<br></pre> | `[]` | no |
| resource\_group\_name | Resource group where the vnet resides. | `string` | n/a | yes |
| reuse\_key | Boolean flag to decide whether to use the existing key again or not | `bool` | `false` | no |
| sku\_name | Name of the SKU used for the key vault | `string` | `"standard"` | no |
| subnet\_id\_maps | One or more Subnet ID's which should be able to access this Key Vault. | `list(string)` | n/a | yes |
| tags | Tags to add to the Load Balancer | `map` | `{}` | no |
| value | List of key valut secret that will cretaed. changing this will force to create new secret. | `list(string)` | <pre>[<br>  ""<br>]<br></pre> | no |
| vault\_key\_tags | Tags to add to the key vault\_key | `map` | `{}` | no |
| vault\_secret\_name | n/a | `list(string)` | <pre>[<br>  ""<br>]<br></pre> | no |
| vault\_secret\_tags | Tag that will be added to the ker vault secret | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_vault\_certificate | Key vault Certificate ID |
| key\_vault\_id | ID of the key vault |
| key\_vault\_url | URI of the key created |
| secrets | n/a |
| thumbprint | Thumbprint of the Key Vault Certificate |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
