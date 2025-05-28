resource "google_storage_bucket" "sensitive_data" {
  name          = "c01-sensitive-data"
  location      = var.region
  project       = google_project.project_b.project_id
  force_destroy = true

  uniform_bucket_level_access {
    enabled = true
  }
}

resource "google_storage_bucket_object" "sensitive_file" {
  name   = "sensitive-data.txt"
  bucket = google_storage_bucket.sensitive_data.name
  source = "sensitive-data.txt"
}
