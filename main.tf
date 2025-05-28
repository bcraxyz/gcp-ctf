provider "google" {
  project = var.project_a
  region  = var.region
  zone    = var.zone
}

provider "google" {
  alias   = "project_b"
  project = var.project_b
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "project_a_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
    "iap.googleapis.com"
  ])
  project = var.project_a
  service = each.key
}

resource "google_project_service" "project_b_apis" {
  provider = google.project_b
  for_each = toset([
    "iam.googleapis.com",
    "storage.googleapis.com"
  ])
  project = var.project_b
  service = each.key
}
