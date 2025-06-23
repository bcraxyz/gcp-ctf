resource "google_project_iam_custom_role" "priv_esc_role" {
  role_id     = "privEscalationRole"
  project     = google_project.project.project_id
  title       = "Privilege Escalation Role"
  description = "Allows setIamPolicy and roles.get"
  permissions = [
    "resourcemanager.projects.setIamPolicy",
    "iam.roles.get",
  ]
}

resource "google_service_account" "gcs_sa" {
  account_id   = "c02-gcs-sa"
  display_name = "GCS Service Account"
  project      = google_project.project.project_id
}

resource "google_project_iam_member" "assign_priv_esc_role" {
  project = google_project.project.project_id
  role    = google_project_iam_custom_role.priv_esc_role.name
  member  = "serviceAccount:${google_service_account.gcs_sa.email}"
}
