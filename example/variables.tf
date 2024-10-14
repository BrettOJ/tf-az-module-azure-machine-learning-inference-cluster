variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Machine Learning Inference Cluster should exist. Changing this forces a new Machine Learning Inference Cluster to be created."
}


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

variable "identity_type" {
  type = string
}

variable "identity_identity_ids" {
  type = list(string)
}

variable "ssl_cert" {
  type = string
}

variable "ssl_cname" {
  type = string
}

variable "ssl_key" {
  type = string
}

variable "ssl_leaf_domain_label" {
  type = string
}

variable "ssl_overwrite_existing_domain" {
  type = string
}


