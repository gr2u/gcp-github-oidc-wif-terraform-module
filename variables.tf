variable "repo" {
  #default     = "owner/repo"
  description = "GitHub repository for which workload identity is being configured. Format: 'owner/repo'."
}

variable "roles" {
  #default     = ["roles/storage.objectUser"]
  description = "IAM roles to assign to the service account. Default is set to 'roles/storage.objectUser'."
}

variable "project_id" {
 #default     = "pet-project"
  description = "ID of the project in Google Cloud Platform where resources are created."
}

variable "pool_id" {
  default     = "github-actions"
  description = "Identifier for the workload identity pool. Default is set to 'github-actions'."
}

variable "pool_description" {
  default     = "Workload identity pool managed by Terraform."
  description = "Description of the workload identity pool."
}

variable "provider_id" {
  default     = "github-actions"
  description = "Identifier for the workload identity pool provider. Default is set to 'github-actions'."
}

variable "provider_description" {
  default     = "Workload identity pool provider managed by Terraform."
  description = "Description of the workload identity pool provider."
}

variable "attribute_condition" {
  #default     = "attribute.repository == \"owner/repo\""
  description = "Attribute condition expression for the workload identity pool provider."
}

variable "attribute_mapping" {
  type        = map(any)
  description = "Attribute mapping for the workload identity pool provider."
  default = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
}
