resource "google_project_iam_custom_role" "pab_esc_role" {
  role_id     = "pabEscalationRole"
  project     = google_project.project.project_id
  title       = "PAB Escalation Role"
  description = "Minimal role for modifying principal access boundary policies."
  permissions = [
    "resourcemanager.projects.get",
    "resourcemanager.projects.setIamPolicy",
    "resourcemanager.projects.getIamPolicy",
    "iam.roles.get"
  ]
}

resource "google_project_iam_member" "ctf_users_can_priv_esc" {
  project = google_project.project.project_id
  role    = google_project_iam_custom_role.pab_esc_role.name
  member  = "group:${var.ctf_users_group}"
}

resource "google_project_iam_member" "ctf_users_compute_viewer" {
  project = google_project.project.project_id
  role    = "roles/compute.viewer"
  member  = "group:${var.ctf_users_group}"
}
