resource "random_id" "suffix" {
  byte_length = 2 # This will generate a 4-character hex string (2 bytes * 2 hex chars/byte)
}

resource "google_project" "project" {
  name            = "Challenge 02 - Project"
  project_id      = "ctf-c02-proj-${random_id.suffix.hex}"
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
  region  = var.region
}
