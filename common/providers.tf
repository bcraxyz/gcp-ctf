provider "google" {
  alias   = "project_a"
  region  = var.region
  zone    = var.zone
}

provider "google" {
  alias   = "project_b"
  region  = var.region
  zone    = var.zone
}
