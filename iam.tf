resource "google_service_account" "vm_sa" {
  provider     = google.project_a
  account_id   = "c01-vm-sa"
  display_name = "VM Service Account"
  project      = var.project_a
}

resource "google_service_account" "gcs_sa" {
  provider     = google.project_b
  account_id   = "c01-gcs-sa"
  display_name = "GCS Service Account"
  project      = var.project_b
}

resource "google_project_iam_member" "vm_sa_impersonate_gcs_sa" {
  project = var.project_b
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_storage_bucket_iam_member" "gcs_sa_bucket_admin" {
  bucket = google_storage_bucket.sensitive_data.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.gcs_sa.email}"
}

resource "google_project_iam_member" "ctf_iap_tunnel_access" {
  project = var.project_a
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "group:${var.ctf_users_group}"
}

resource "google_project_iam_member" "ctf_compute_viewer" {
  project = var.project_a
  role    = "roles/compute.instanceViewer"
  member  = "group:${var.ctf_users_group}"
}

resource "google_project_iam_member" "ctf_os_login" {
  project = var.project_a
  role    = "roles/compute.osLogin"
  member  = "group:${var.ctf_users_group}"
}
