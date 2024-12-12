resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {  ##Depolama kabı, verilerinizi düzenli bir şekilde saklamak ve yönetmek için kullanışlıdır.
  name                  = "container-name"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# Other storage-related resources...

# Azure PostgreSQL Server
resource "azurerm_postgresql_server" "pgresql" {
  name                = var.postgresql_server_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  version             = "11"

  administrator_login          = var.postgresql_username
  administrator_login_password = var.postgresql_password
  ssl_enforcement_enabled      = true
  ssl_minimal_tls_version      = "TLS1_2"
}
