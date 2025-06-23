module "challenge01" {
  source = "./"

  region              = var.region
  zone                = var.zone
  org_id              = var.org_id
  billing_account_id  = var.billing_account_id
  ctf_users_group     = var.ctf_users_group
  ctf_folder_id       = var.ctf_folder_id
}
