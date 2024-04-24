# locals, data, resources, client config

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" { #data rather than resource, because we want to read not write!!!
  name = local.rg
}

resource "random_password" "name" {
  for_each = local.secret_keys
  length = 10
}

resource "azurerm_key_vault_secret" "secret" {
  name         = local.secret_name
  value        = random_password.name[each.key]   #.result for random inputs to retrieve outputs!
  key_vault_id = azurerm_key_vault.key_vault.id
}

resource "azurerm_role_assignment" "Administrator" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}


resource "azurerm_key_vault" "key_vault" {
  name                        = local.kv
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  enable_rbac_authorization = true

  contact {
    email = local.email
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create"
    ]

    secret_permissions = [
      "Get", "Set"
    ]

  }

  tags = {
    user   = var.owner
    env    = var.env
  }

}


locals {
  rg           = format("jm_tf_keyvault")
  kv           = format("%s-key-vault", var.owner)
  email        = format("%s%s@gmail.com", var.firstname, var.lastname)
  secret_name  = format("%s-keyvault-secret", var.owner)
  secret_value = format("%s-keyvault-secret", var.random)
  secret_keys  = toset(["key1", "key2", "key3"])
}
