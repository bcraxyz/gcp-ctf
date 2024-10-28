# Create project and enable APIs
resource "google_project" "ctf_project" {
  name            = var.project_name
  project_id      = var.project_id
  org_id          = var.org_id
  billing_account = var.billing_account
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com"
  ])

  project = google_project.ctf_project.project_id
  service = each.value

  disable_dependent_services = true
  disable_on_destroy        = false
}

# Create admin service account
resource "google_service_account" "ctf_admin" {
  project      = google_project.ctf_project.project_id
  account_id   = "ctf-admin"
  display_name = "CTF Admin Service Account"
}

resource "google_project_iam_member" "ctf_admin_roles" {
  for_each = toset([
    "roles/compute.admin",
    "roles/container.admin",
    "roles/iam.serviceAccountUser"
  ])

  project = google_project.ctf_project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.ctf_admin.email}"
}

# Include Challenge 1
module "challenge_1" {
  source = "./modules/challenges/challenge-1"
  
  project_id = google_project.ctf_project.project_id
  region     = var.region
}
