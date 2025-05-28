provider "google" {
  alias   = "project_a" 
  project = google_project.project_a.project_id
  region  = var.region
  zone    = var.zone
}

provider "google" {
  alias   = "project_b"
  project = google_project.project_b.project_id
  region  = var.region
  zone    = var.zone
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
