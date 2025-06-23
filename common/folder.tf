resource "google_folder" "ctf_folder" {
  display_name = "CTF"
  parent       = "organizations/${var.org_id}"
}

output "ctf_folder_name" {
  value = google_folder.ctf_folder.name
}
