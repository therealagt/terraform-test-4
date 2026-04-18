locals {
  region = "europe-west1"
}

resource "google_compute_router" "nat_router" {
  name    = "core-nat-router"
  project = var.project_id
  network = module.test-vpc-module.network_name
  region  = local.region

  description = "Cloud Router for Cloud NAT"
}

resource "google_compute_router_nat" "main" {
  name                               = "core-cloud-nat"
  project                            = var.project_id
  router                             = google_compute_router.nat_router.name
  region                             = google_compute_router.nat_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  min_ports_per_vm                = 64
  enable_endpoint_independent_mapping = true

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
