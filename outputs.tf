# outputs = kv name, kv url

output "key_vault_name" {
  value       = azurerm_key_vault.key_vault.name
  description = "key vault's name"
}

output "key_vault_url" {
  value       = azurerm_key_vault.key_vault.vault_uri
  description = "key vault's URL"
}