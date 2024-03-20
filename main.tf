terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.19.0"
    }
    
    google-beta = {
      source = "hashicorp/google-beta"
      version = "5.19.0"

    }
  }
}
# Define local variables for convenience
locals {
  # ID for the Git OIDC service account
  git_oidc_sa_account_id = "${element(split("/", var.repo), 1)}-git-oidc-sa"
  # ID for the workload identity pool
  git_workload_identity_pool_id = "git-${replace(var.repo, "/", "-")}-pool-id"
  # ID for the workload identity pool provider
  git_workload_identity_pool_provider_id = "git-${replace(var.repo, "/", "-")}-provider-id"
}

# Create a Google Cloud service account for Git OIDC
resource "google_service_account" "git_oidc_sa" {
  account_id   = local.git_oidc_sa_account_id
  display_name = "Git OIDC Service Account"
  project      = var.project_id
}

# Assign roles to the service account in the project
resource "google_project_iam_member" "git_oidc_sa_roles" {
  project = var.project_id

  # Loop through the roles list and assign each role to the service account
  for_each = {
    for role in var.roles : role => role
  }

  role = each.value
  # Assign the service account as a member
  member = "serviceAccount:${google_service_account.git_oidc_sa.email}"
}

# Create a Google Cloud IAM workload identity pool
resource "google_iam_workload_identity_pool" "github_actions" {
  provider = google-beta
  project  = var.project_id

  # Loop through the local workload identity pool IDs and create a pool for each
  for_each = {
    for pool_id in local.git_workload_identity_pool_id : pool_id => pool_id
  }

  workload_identity_pool_id = each.value
  display_name              = each.value
}

# Create a Google Cloud IAM workload identity pool provider
resource "google_iam_workload_identity_pool_provider" "github_actions" {
  provider    = google-beta
  project     = var.project_id
  description = var.pool_description

  # Loop through the created workload identity pools and create a provider for each
  for_each = google_iam_workload_identity_pool.git_workload_identity_pool

  workload_identity_pool_id          = each.key
  workload_identity_pool_provider_id = local.git_workload_identity_pool_provider_id
  display_name                       = local.git_workload_identity_pool_provider_id
  # attribute_condition                = var.attribute_condition
  attribute_mapping                  = var.attribute_mapping

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}


# Assign a role to the service account for each workload identity pool
resource "google_service_account_iam_member" "github_actions_oidc_wif" {
  for_each = google_iam_workload_identity_pool.git_workload_identity_pool

  service_account_id = google_service_account.git_oidc_sa.name
  role               = "roles/iam.workloadIdentityUser"
  # Define the member for the workload identity pool
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.git_workload_identity_pool[each.key].name}/attribute.repository/${var.repo}"
}

# Output the list of workload identity pool providers
output "google_iam_workload_identity_pool_providers" {
  value = google_iam_workload_identity_pool_provider.git_workload_identity_pool_provider
}

# Output information about the service account
output "git_oidc_sa_info" {
  value = google_service_account.git_oidc_sa
}
