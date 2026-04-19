output "app_mig_name" {
  description = "Name of the regional app MIG"
  value       = google_compute_region_instance_group_manager.app.name
}

output "app_instance_group" {
  description = "Self link of the managed instance group used as LB backend"
  value       = google_compute_region_instance_group_manager.app.instance_group
}

output "app_instance_template" {
  description = "Self link of the app instance template"
  value       = google_compute_instance_template.app.self_link
}

output "db_instance_name" {
  description = "Name of the DB VM"
  value       = google_compute_instance.db_vm.name
}

output "db_internal_ip" {
  description = "Internal IP of the DB VM"
  value       = google_compute_instance.db_vm.network_interface[0].network_ip
}

output "audit_instance_name" {
  description = "Name of the audit VM"
  value       = google_compute_instance.audit_vm.name
}

output "audit_internal_ip" {
  description = "Internal IP of the audit VM"
  value       = google_compute_instance.audit_vm.network_interface[0].network_ip
}
