resource "google_service_account" "vm_sa" {
  provider     = google.project_a
  account_id   = "c01-vm-sa"
  display_name = "VM Service Account"
  project      = google_project.project_a.project_id
}

resource "google_service_account" "gcs_sa" {
  provider     = google.project_b
  account_id   = "c01-gcs-sa"
  display_name = "GCS Service Account"
  project      = google_project.project_b.project_id
}

resource "google_service_account_iam_member" "vm_sa_impersonate_gcs_sa" {
  service_account_id = google_service_account.gcs_sa.name
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_service_account_iam_member" "vm_sa_token_creator_for_gcs_sa" {
  service_account_id = google_service_account.gcs_sa.name
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_project_iam_member" "gcs_sa_storage_viewer" {
  project = google_project.project_b.project_id
  role    = "roles/storage.viewer"
  member  = "serviceAccount:${google_service_account.gcs_sa.email}"
}

resource "google_storage_bucket_iam_member" "gcs_sa_bucket_admin" {
  bucket = google_storage_bucket.sensitive_data.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.gcs_sa.email}"
}

resource "google_project_iam_member" "ctf_iap_tunnel_access" {
  project = google_project.project_a.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "group:${var.ctf_users_group}"
}

resource "google_project_iam_member" "ctf_compute_viewer" {
  project = google_project.project_a.project_id
  role    = "roles/compute.viewer"
  member  = "group:${var.ctf_users_group}"
}

resource "google_project_iam_member" "ctf_os_login" {
  project = google_project.project_a.project_id
  role    = "roles/compute.osLogin"
  member  = "group:${var.ctf_users_group}"
}
