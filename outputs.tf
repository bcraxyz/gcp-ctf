output "vm_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "vm_service_account" {
  value = google_service_account.vm_sa.email
}

output "gcs_service_account" {
  value = google_service_account.gcs_sa.email
}

output "bucket_name" {
  value = google_storage_bucket.sensitive_data.name
}
