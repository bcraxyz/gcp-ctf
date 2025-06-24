resource "google_project" "project" {
  name            = "Challenge 02 - Project"
  project_id      = "ctf-c02-proj"
  folder_id       = var.ctf_folder_id
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_project_service" "project_apis" {
  for_each = toset([
    "resourcemanager.googleapis.com",
    "iam.googleapis.com",
  ])
  project = google_project.project.project_id
  service = each.key
}

provider "google" {
  project = google_project.project.project_id
  region  = var.region
}
