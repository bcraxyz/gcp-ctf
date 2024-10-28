output "project_id" {
  value = google_project.ctf_project.project_id
}

output "service_account_email" {
  value = google_service_account.ctf_admin.email
}
