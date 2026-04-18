locals {
  vpc_name = "my-custom-mode-network"
  backend_ports = ["80", "443"]

  subnet_cidrs = {
    app   = "10.10.10.0/24"
    proxy = "10.10.20.0/24"
    frontend = "10.10.30.0/24"
    db    = "10.10.40.0/24"
    audit = "10.10.50.0/24"
  }

  target_tags = {
    app   = "app"
    db    = "db"
    audit = "audit"
  }
}

resource "google_compute_firewall" "allow_ilb_proxy_to_app" {
  name      = "allow-ilb-proxy-to-app"
  network   = local.vpc_name
  project   = var.project_id
  direction = "INGRESS"
  priority  = 1000

  source_ranges = [local.subnet_cidrs.proxy]
  target_tags   = [local.target_tags.app]

  allow {
    protocol = "tcp"
    ports    = local.backend_ports
  }

  description = "Allow traffic from proxy-only subnet to app backends"
}

resource "google_compute_firewall" "allow_hc_to_app" {
  name      = "allow-health-checks-to-app"
  network   = local.vpc_name
  project   = var.project_id
  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = [local.target_tags.app]

  allow {
    protocol = "tcp"
    ports    = local.backend_ports
  }

  description = "Allow Google Cloud health checks to app backends"
}

resource "google_compute_firewall" "allow_app_to_db" {
  name      = "allow-app-to-db"
  network   = local.vpc_name
  project   = var.project_id
  direction = "INGRESS"
  priority  = 1000

  source_ranges = [local.subnet_cidrs.app]
  target_tags   = [local.target_tags.db]

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  description = "Allow PostgreSQL traffic from app subnet to DB targets"
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name      = "allow-iap-ssh"
  network   = local.vpc_name
  project   = var.project_id
  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"]
  target_tags   = [local.target_tags.app, local.target_tags.db, local.target_tags.audit]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  description = "Allow SSH via IAP to tagged instances"
}

resource "google_compute_firewall" "allow_egress_common" {
  name      = "allow-egress-common"
  network   = local.vpc_name
  project   = var.project_id
  direction = "EGRESS"
  priority  = 1000

  destination_ranges = ["0.0.0.0/0"]
  target_tags        = [local.target_tags.app, local.target_tags.db, local.target_tags.audit]

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "53"]
  }

  allow {
    protocol = "udp"
    ports    = ["53", "123"]
  }

  description = "Allow common outbound traffic"
}

resource "google_compute_firewall" "deny_egress_all" {
  name      = "deny-egress-all"
  network   = local.vpc_name
  project   = var.project_id
  direction = "EGRESS"
  priority  = 2000

  destination_ranges = ["0.0.0.0/0"]
  target_tags        = [local.target_tags.app, local.target_tags.db, local.target_tags.audit]

  deny {
    protocol = "all"
  }

  description = "Deny all other outbound traffic for tagged instances"
}
