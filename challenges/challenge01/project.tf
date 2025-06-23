resource "google_project" "project_a" {
  name            = "Challenge 01 - Project A"
  project_id      = "ctf-c01-proj-a"
  folder_id       = var.ctf_folder_id
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_project" "project_b" {
  name            = "Challenge 01 - Project B"
  project_id      = "ctf-c01-proj-b"
  folder_id       = var.ctf_folder_id
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_project_service" "project_a_apis" {
  provider = google.project_a
  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
    "iap.googleapis.com"
  ])
  project = google_project.project_a.project_id
  service = each.key
}

resource "google_project_service" "project_b_apis" {
  provider = google.project_b
  for_each = toset([
    "iam.googleapis.com",
    "storage.googleapis.com"
  ])
  project = google_project.project_b.project_id
  service = each.key
}
