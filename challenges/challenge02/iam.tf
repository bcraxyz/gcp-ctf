resource "google_project_iam_custom_role" "priv_esc_role" {
  role_id     = "privEscalationRole"
  project     = google_project.project.project_id
  title       = "Privilege Escalation Role"
  description = "Allows project visibility and privilege escalation"
  permissions = [
    "resourcemanager.projects.get",
    "resourcemanager.projects.setIamPolicy",
    "iam.roles.get",
  ]
}

resource "google_project_iam_member" "ctf_users_can_priv_esc" {
  project = google_project.project.project_id
  role    = google_project_iam_custom_role.priv_esc_role.name
  member  = "group:${var.ctf_users_group}"
}
