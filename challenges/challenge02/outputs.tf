output "project_id" {
  value = google_project.project.project_id
}

output "gcs_service_account" {
  value = google_service_account.gcs_sa.email
}

output "bucket_name" {
  value = google_storage_bucket.sensitive_data.name
}
