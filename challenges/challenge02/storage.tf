resource "random_id" "suffix" {
  byte_length = 2 # This will generate a 4-character hex string (2 bytes * 2 hex chars/byte)
}

resource "google_storage_bucket" "sensitive_data" {
  name                        = "c02-sensitive-data-${random_id.suffix.hex}"
  location                    = var.region
  project                     = google_project.project.project_id
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "sensitive_file" {
  name   = "sensitive-data.txt"
  bucket = google_storage_bucket.sensitive_data.name
  source = "${path.module}/sensitive-data.txt"
}
