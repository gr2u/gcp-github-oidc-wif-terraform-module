```markdown
# Terraform Module: GCP Workload Identity

This Terraform module manages workload identity in Google Cloud Platform (GCP) and facilitates the use of a Git OIDC service account.
```
## Features

- Creates a Google Cloud service account for Git OIDC.
- Assigns specified roles to the Git OIDC service account within the project.
- Establishes a Google IAM workload identity pool.
- Sets up a Google IAM workload identity pool provider.
- Grants the "iam.workloadIdentityUser" role to the Git OIDC service account for each workload identity pool.
- Provides outputs detailing information about the created workload identity pool providers and the Git OIDC service account.

## Usage

```hcl
module "gcp_workload_identity" {
  source = "github.com/gr2u/terraform-gcp-workload-identity"

  project_id           = "your-project-id"
  repo                 = "your-org/your-repo"
  roles                = ["roles/storage.objectViewer"]
  pool_description     = "Workload Identity Pool managed by Terraform"
  attribute_condition  = "attribute.repository == \"your-org/your-repo\""
  attribute_mapping    = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
}
```


<!-- ## Inputs

- `project_id` (required): The ID of the GCP project.
- `repo` (required): The repository identifier in the format `your-org/repo`.
- `roles` (required): A list of roles to assign to the service account.
- `pool_description` (optional): Description for the workload identity pool.
- `attribute_condition` (required): Attribute condition expression for the workload identity pool provider.
- `attribute_mapping` (required): Attribute mapping for the workload identity pool provider. -->
<!-- 
## Outputs

- `google_iam_workload_identity_pool_providers`: Information about the created workload identity pool providers.
- `sa_info`: Information about the created Git OIDC service account. -->


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.19.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 5.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.19.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_iam_workload_identity_pool.github_actions](https://registry.terraform.io/providers/hashicorp/google-beta/5.19.0/docs/resources/google_iam_workload_identity_pool) | resource |
| [google-beta_google_iam_workload_identity_pool_provider.github_actions](https://registry.terraform.io/providers/hashicorp/google-beta/5.19.0/docs/resources/google_iam_workload_identity_pool_provider) | resource |
| [google_project_iam_member.git_oidc_sa_roles](https://registry.terraform.io/providers/hashicorp/google/5.19.0/docs/resources/project_iam_member) | resource |
| [google_service_account.git_oidc_sa](https://registry.terraform.io/providers/hashicorp/google/5.19.0/docs/resources/service_account) | resource |
| [google_service_account_iam_member.github_actions_oidc_wif](https://registry.terraform.io/providers/hashicorp/google/5.19.0/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attribute_condition"></a> [attribute\_condition](#input\_attribute\_condition) | Attribute condition expression for the workload identity pool provider. | `any` | n/a | yes |
| <a name="input_attribute_mapping"></a> [attribute\_mapping](#input\_attribute\_mapping) | Attribute mapping for the workload identity pool provider. | `map(any)` | <pre>{<br>  "attribute.actor": "assertion.actor",<br>  "attribute.aud": "assertion.aud",<br>  "attribute.repository": "assertion.repository",<br>  "attribute.repository_owner": "assertion.repository_owner",<br>  "google.subject": "assertion.sub"<br>}</pre> | no |
| <a name="input_pool_description"></a> [pool\_description](#input\_pool\_description) | Description of the workload identity pool. | `string` | `"Workload identity pool managed by Terraform."` | no |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Identifier for the workload identity pool. Default is set to 'github-actions'. | `string` | `"github-actions"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project in Google Cloud Platform where resources are created. | `any` | n/a | yes |
| <a name="input_provider_description"></a> [provider\_description](#input\_provider\_description) | Description of the workload identity pool provider. | `string` | `"Workload identity pool provider managed by Terraform."` | no |
| <a name="input_provider_id"></a> [provider\_id](#input\_provider\_id) | Identifier for the workload identity pool provider. Default is set to 'github-actions'. | `string` | `"github-actions"` | no |
| <a name="input_repo"></a> [repo](#input\_repo) | GitHub repository for which workload identity is being configured. Format: 'owner/repo'. | `any` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | IAM roles to assign to the service account. Default is set to 'roles/storage.objectUser'. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_git_oidc_sa_info"></a> [git\_oidc\_sa\_info](#output\_git\_oidc\_sa\_info) | Output information about the service account |
| <a name="output_google_iam_workload_identity_pool_providers"></a> [google\_iam\_workload\_identity\_pool\_providers](#output\_google\_iam\_workload\_identity\_pool\_providers) | Output the list of workload identity pool providers |
<!-- END_TF_DOCS -->