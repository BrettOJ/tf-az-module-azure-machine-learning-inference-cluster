Manages a Machine Learning Inference Cluster.

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#example-usage)

```hcl
data "azurerm_client_config" "current" {} resource "azurerm_resource_group" "example" { name = "example-rg" location = "west europe" tags = { "stage" = "example" } } resource "azurerm_application_insights" "example" { name = "example-ai" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name application_type = "web" } resource "azurerm_key_vault" "example" { name = "example-kv" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name tenant_id = data.azurerm_client_config.current.tenant_id sku_name = "standard" purge_protection_enabled = true } resource "azurerm_storage_account" "example" { name = "examplesa" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name account_tier = "Standard" account_replication_type = "LRS" } resource "azurerm_machine_learning_workspace" "example" { name = "example-mlw" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name application_insights_id = azurerm_application_insights.example.id key_vault_id = azurerm_key_vault.example.id storage_account_id = azurerm_storage_account.example.id identity { type = "SystemAssigned" } } resource "azurerm_virtual_network" "example" { name = "example-vnet" address_space = ["10.1.0.0/16"] location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name } resource "azurerm_subnet" "example" { name = "example-subnet" resource_group_name = azurerm_resource_group.example.name virtual_network_name = azurerm_virtual_network.example.name address_prefixes = ["10.1.0.0/24"] } resource "azurerm_kubernetes_cluster" "example" { name = "example-aks" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name dns_prefix_private_cluster = "prefix" default_node_pool { name = "default" node_count = 3 vm_size = "Standard_D3_v2" vnet_subnet_id = azurerm_subnet.example.id } identity { type = "SystemAssigned" } } resource "azurerm_machine_learning_inference_cluster" "example" { name = "example" location = azurerm_resource_group.example.location cluster_purpose = "FastProd" kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id description = "This is an example cluster used with Terraform" machine_learning_workspace_id = azurerm_machine_learning_workspace.example.id tags = { "stage" = "example" } }
```

## [Arguments Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#arguments-reference)

The following arguments are supported:

-   [`name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#name) - (Required) The name which should be used for this Machine Learning Inference Cluster. Changing this forces a new Machine Learning Inference Cluster to be created.
    
-   [`kubernetes_cluster_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#kubernetes_cluster_id) - (Required) The ID of the Kubernetes Cluster. Changing this forces a new Machine Learning Inference Cluster to be created.
    
-   [`location`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#location) - (Required) The Azure Region where the Machine Learning Inference Cluster should exist. Changing this forces a new Machine Learning Inference Cluster to be created.
    
-   [`machine_learning_workspace_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#machine_learning_workspace_id) - (Required) The ID of the Machine Learning Workspace. Changing this forces a new Machine Learning Inference Cluster to be created.
    

___

-   [`cluster_purpose`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#cluster_purpose) - (Optional) The purpose of the Inference Cluster. Options are `DevTest`, `DenseProd` and `FastProd`. If used for Development or Testing, use `DevTest` here. Default purpose is `FastProd`, which is recommended for production workloads. Changing this forces a new Machine Learning Inference Cluster to be created.

-   [`description`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#description) - (Optional) The description of the Machine Learning Inference Cluster. Changing this forces a new Machine Learning Inference Cluster to be created.
    
-   [`identity`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#identity) - (Optional) An `identity` block as defined below. Changing this forces a new Machine Learning Inference Cluster to be created.
    
-   [`ssl`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#ssl) - (Optional) A `ssl` block as defined below. Changing this forces a new Machine Learning Inference Cluster to be created.
    
-   [`tags`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#tags) - (Optional) A mapping of tags which should be assigned to the Machine Learning Inference Cluster. Changing this forces a new Machine Learning Inference Cluster to be created.
    

___

An `identity` block supports the following:

-   [`type`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#type) - (Required) Specifies the type of Managed Service Identity that should be configured on this Machine Learning Inference Cluster. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both). Changing this forces a new resource to be created.
    
-   [`identity_ids`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#identity_ids) - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Machine Learning Inference Cluster. Changing this forces a new resource to be created.
    

___

A `ssl` block supports the following:

-   [`cert`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#cert) - (Optional) The certificate for the SSL configuration.Conflicts with `ssl[0].leaf_domain_label`,`ssl[0].overwrite_existing_domain`. Changing this forces a new Machine Learning Inference Cluster to be created. Defaults to `""`.
    
-   [`cname`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#cname) - (Optional) The cname of the SSL configuration.Conflicts with `ssl[0].leaf_domain_label`,`ssl[0].overwrite_existing_domain`. Changing this forces a new Machine Learning Inference Cluster to be created. Defaults to `""`.
    
-   [`key`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#key) - (Optional) The key content for the SSL configuration.Conflicts with `ssl[0].leaf_domain_label`,`ssl[0].overwrite_existing_domain`. Changing this forces a new Machine Learning Inference Cluster to be created. Defaults to `""`.
    
-   [`leaf_domain_label`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#leaf_domain_label) - (Optional) The leaf domain label for the SSL configuration. Conflicts with `ssl[0].cert`,`ssl[0].key`,`ssl[0].cname`. Changing this forces a new Machine Learning Inference Cluster to be created. Defaults to `""`.
    
-   [`overwrite_existing_domain`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#overwrite_existing_domain) - (Optional) Whether or not to overwrite existing leaf domain. Conflicts with `ssl[0].cert`,`ssl[0].key`,`ssl[0].cname` Changing this forces a new Machine Learning Inference Cluster to be created. Defaults to `""`.
    

## [Attributes Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#attributes-reference)

In addition to the Arguments listed above - the following Attributes are exported:

-   [`id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#id) - The ID of the Machine Learning Inference Cluster.
    
-   [`identity`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#identity) - An `identity` block as defined below, which contains the Managed Service Identity information for this Machine Learning Inference Cluster.
    

___

A `identity` block exports the following:

-   [`principal_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#principal_id) - The Principal ID for the Service Principal associated with the Managed Service Identity of this Machine Learning Inference Cluster.
    
-   [`tenant_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#tenant_id) - The Tenant ID for the Service Principal associated with the Managed Service Identity of this Machine Learning Inference Cluster.
    

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#create) - (Defaults to 30 minutes) Used when creating the Machine Learning Inference Cluster.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#read) - (Defaults to 5 minutes) Used when retrieving the Machine Learning Inference Cluster.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#delete) - (Defaults to 30 minutes) Used when deleting the Machine Learning Inference Cluster.

## [Import](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_inference_cluster#import)

Machine Learning Inference Clusters can be imported using the `resource id`, e.g.

```shell
terraform import azurerm_machine_learning_inference_cluster.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resGroup1/providers/Microsoft.MachineLearningServices/workspaces/workspace1/computes/cluster1
```