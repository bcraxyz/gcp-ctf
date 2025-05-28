resource "google_folder" "ctf_folder" {
  display_name = "CTF"
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "project_a" {
  name            = "Challenge 01 Project A"
  project_id      = "c01-proj-a"
  folder_id       = google_folder.ctf_folder.name
  billing_account = var.billing_account_id
}

resource "google_project" "project_b" {
  name            = "Challenge 01 Project B"
  project_id      = "c01-proj-b"
  folder_id       = google_folder.ctf_folder.name
  billing_account = var.billing_account_id
}
