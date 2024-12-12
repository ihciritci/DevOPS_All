output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "postgresql_server_name" {
  value = azurerm_postgresql_server.pgresql.name
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

output "network_security_group_name" {
  value = azurerm_network_security_group.sg.name
}
