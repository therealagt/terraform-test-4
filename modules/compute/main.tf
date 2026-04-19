data "google_compute_subnetwork" "app" {
	name    = var.app_subnet_name
	project = var.project_id
	region  = var.region
}

data "google_compute_subnetwork" "db" {
	name    = var.db_subnet_name
	project = var.project_id
	region  = var.region
}

data "google_compute_subnetwork" "audit" {
	name    = var.audit_subnet_name
	project = var.project_id
	region  = var.region
}

resource "google_compute_instance_template" "app" {
	name_prefix  = var.app_template_name_prefix
	project      = var.project_id
	machine_type = var.app_machine_type
	tags         = ["app"]

	disk {
		auto_delete  = true
		boot         = true
		disk_size_gb = var.app_boot_disk_size_gb
		disk_type    = var.app_boot_disk_type
		source_image = var.app_boot_image
	}

	network_interface {
		subnetwork = data.google_compute_subnetwork.app.self_link
	}

	service_account {
		scopes = ["https://www.googleapis.com/auth/cloud-platform"]
	}
}

resource "google_compute_region_instance_group_manager" "app" {
	name                    = var.app_mig_name
	project                 = var.project_id
	region                  = var.region
	base_instance_name      = "app"
	target_size             = var.app_mig_target_size
	distribution_policy_zones = var.mig_zones

	version {
		name              = "primary"
		instance_template = google_compute_instance_template.app.id
	}

	named_port {
		name = "http"
		port = 80
	}

	update_policy {
		type                  = "PROACTIVE"
		minimal_action        = "REPLACE"
		replacement_method    = "SUBSTITUTE"
		max_surge_fixed       = 1
		max_unavailable_fixed = 0
	}
}

resource "google_compute_instance" "db_vm" {
	name         = var.db_instance_name
	project      = var.project_id
	zone         = var.zone
	machine_type = var.db_machine_type
	tags         = ["db"]

	boot_disk {
		initialize_params {
			image = var.db_boot_image
			size  = var.db_boot_disk_size_gb
			type  = var.db_boot_disk_type
		}
	}

	network_interface {
		subnetwork = data.google_compute_subnetwork.db.self_link
	}
}

resource "google_compute_instance" "audit_vm" {
	name         = var.audit_instance_name
	project      = var.project_id
	zone         = var.zone
	machine_type = var.audit_machine_type
	tags         = ["audit"]

	boot_disk {
		initialize_params {
			image = var.audit_boot_image
			size  = var.audit_boot_disk_size_gb
			type  = var.audit_boot_disk_type
		}
	}

	network_interface {
		subnetwork = data.google_compute_subnetwork.audit.self_link
	}
}
