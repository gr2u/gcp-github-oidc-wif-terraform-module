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

<!-- END_TF_DOCS -->