variable "location" {
  description = "Azure region"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "cluster_name" {
  description = "Azure Kubernetes Service (AKS) cluster name"
  type        = string
}

variable "postgresql_server_name" {
  description = "Azure PostgreSQL Server name"
  type        = string
}

variable "storage_account_name" {
  description = "Azure Storage Account name"
  type        = string
}

variable "network_security_group_name" {
  description = "Azure Network Security Group name"
  type        = string
}

// Diğer değişkenler...
