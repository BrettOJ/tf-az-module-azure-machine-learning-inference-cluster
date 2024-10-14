data "azurerm_client_config" "current" {}

locals {
  naming_convention_info = {
    project_code = "ai"
    env          = "env"
    zone         = "zone"
    tier         = "tier"
    name         = "001"
    agency_code  = "na"
  }
  tags = {
    environment = "Production"
  }

}
data "azurerm_client_config" "current" {}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {
      }
    }
  }
}

resource "azurerm_application_insights" "example" {
  name                = "example-ai"
  location                                = var.location
  resource_group_name                     = module.resource_groups.rg_output[1].name
  application_type    = "web"
}

resource "azurerm_key_vault" "example" {
  name                = "example-kv"
  location                                = var.location
  resource_group_name                     = module.resource_groups.rg_output[1].name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  purge_protection_enabled = true
}

resource "azurerm_storage_account" "example" {
  name                     = "examplesa"
  location                                = var.location
  resource_group_name                     = module.resource_groups.rg_output[1].name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_machine_learning_workspace" "example" {
  name                    = "example-mlw"
  location                                = var.location
  resource_group_name                     = module.resource_groups.rg_output[1].name
  application_insights_id = azurerm_application_insights.example.id
  key_vault_id            = azurerm_key_vault.example.id
  storage_account_id      = azurerm_storage_account.example.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.1.0.0/16"]
  location                                = var.location
  resource_group_name                     = module.resource_groups.rg_output[1].name
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name                     = module.resource_groups.rg_output[1].name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_kubernetes_cluster" "example" {
  name                       = "example-aks"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  dns_prefix_private_cluster = "prefix"

  default_node_pool {
    name           = "default"
    node_count     = 3
    vm_size        = "Standard_D3_v2"
    vnet_subnet_id = azurerm_subnet.example.id
  }

  identity {
    type = "SystemAssigned"
  }
}

module "azurerm_machine_learning_inference_cluster" {
  source                = "../"
  location                      = var.location
  cluster_purpose               = var.cluster_purpose
  kubernetes_cluster_id         = var.kubernetes_cluster_id
  description                   = var.description
  machine_learning_workspace_id = var.machine_learning_workspace_id

  identity = {
    type         = "SystemAssigned"
    identity_ids = []
  }

  ssl = {
    cert                      = var.ssl_cert
    cname                     = var.ssl_cname
    key                       = var.ssl_key
    leaf_domain_label         = var.ssl_leaf_domain_label
    overwrite_existing_domain = var.ssl_overwrite_existing_domain
  }

  tags = local.tags
}