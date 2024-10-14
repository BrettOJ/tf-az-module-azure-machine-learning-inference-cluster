
variable "kubernetes_cluster_id" {
  description = "(Required) The ID of the Kubernetes Cluster. Changing this forces a new Machine Learning Inference Cluster to be created."
}

variable "location" {
  description = "(Required) The Azure Region where the Machine Learning Inference Cluster should exist. Changing this forces a new Machine Learning Inference Cluster to be created."
}

variable "machine_learning_workspace_id" {
  description = "(Required) The ID of the Machine Learning Workspace. Changing this forces a new Machine Learning Inference Cluster to be created."
}

variable "cluster_purpose" {
  description = "(Optional) The purpose of the Inference Cluster. Options are DevTest, DenseProd and FastProd. If used for Development or Testing, use DevTest here. Default purpose is FastProd, which is recommended for production workloads. Changing this forces a new Machine Learning Inference Cluster to be created."
}

variable "description" {
  description = "(Optional) The description of the Machine Learning Inference Cluster. Changing this forces a new Machine Learning Inference Cluster to be created."
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to the Machine Learning Inference Cluster. Changing this forces a new Machine Learning Inference Cluster to be created."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "ssl" {
  type = object({
    cert                      = string
    cname                     = string
    key                       = string
    leaf_domain_label         = string
    overwrite_existing_domain = string
  })
}

variable "naming_convention_info" {
  type = object({
    project_code = string
    env          = string
    zone         = string
    tier         = string
    name         = string
    agency_code  =  string
  })
  
}