module "challenge02" {
  source = "./"

  region             = var.region
  billing_account_id = var.billing_account_id
  ctf_folder_id      = var.ctf_folder_id
}
