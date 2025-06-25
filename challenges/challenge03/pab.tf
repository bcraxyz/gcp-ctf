resource "google_access_context_manager_access_policy" "ctf_policy" {
  title        = "Challenge 03 Access Policy"
  parent       = "organizations/${var.org_id}"
}

resource "google_access_context_manager_service_perimeter" "ctf_pab" {
  parent         = google_access_context_manager_access_policy.ctf_policy.name
  name           = "${google_access_context_manager_access_policy.ctf_policy.name}/servicePerimeters/ctf-pab"
  title          = "Principal Access Boundary"
  perimeter_type = "PERIMETER_TYPE_REGULAR"

  status {
    resources = [
      "projects/${google_project.project.number}"
    ]

    restricted_services = []
    access_levels       = []
  }
}

resource "google_access_context_manager_service_perimeter_resource" "attach_project" {
  perimeter_name = google_access_context_manager_service_perimeter.ctf_pab.name
  resource       = "projects/${google_project.project.number}"
}

resource "google_access_context_manager_access_policy_iam_binding" "bind_ctf_users" {
  policy  = google_access_context_manager_access_policy.ctf_policy.name
  role    = "roles/accesscontextmanager.policyReader"
  members = [
    "group:${var.ctf_users_group}"
  ]
}
