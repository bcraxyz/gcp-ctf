resource "google_folder" "ctf_folder" {
  display_name = "CTF"
  parent       = "organizations/${var.org_id}"
  
  deletion_protection = false
}
