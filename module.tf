
resource "azurerm_machine_learning_inference_cluster" "az_ml_ic" {
  name                          = module.azml_ws_name.naming_convention_output[var.naming_convention_info.name].names.0
  location                      = var.location
  cluster_purpose               = var.cluster_purpose
  kubernetes_cluster_id         = var.kubernetes_cluster_id
  description                   = var.description
  machine_learning_workspace_id = var.machine_learning_workspace_id

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  ssl {
    cert                      = var.ssl.cert
    cname                     = var.ssl.cname
    key                       = var.ssl.key
    leaf_domain_label         = var.ssl.leaf_domain_label
    overwrite_existing_domain = var.ssl.overwrite_existing_domain
  }

  tags = var.tags
}