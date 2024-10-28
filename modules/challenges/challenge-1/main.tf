# TODO

resource "google_compute_network" "challenge_1_net" {
  name                    = "challenge-1-net"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "challenge_1_subnet" {
  name          = "challenge-1-subnet"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.challenge_1_net.self_link
  ip_cidr_range = "10.140.0.0/24"
}
