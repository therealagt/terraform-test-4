variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP zone for singleton VMs"
  type        = string
  default     = "europe-west1-b"
}

variable "app_subnet_name" {
  description = "Subnet name for app workload"
  type        = string
  default     = "subnet-01"
}

variable "db_subnet_name" {
  description = "Subnet name for DB VM"
  type        = string
  default     = "subnet-04"
}

variable "audit_subnet_name" {
  description = "Subnet name for audit VM"
  type        = string
  default     = "subnet-05"
}

variable "app_template_name_prefix" {
  description = "Prefix for app instance template name"
  type        = string
  default     = "app-template-"
}

variable "app_mig_name" {
  description = "Regional managed instance group name for app"
  type        = string
  default     = "app-mig"
}

variable "app_mig_target_size" {
  description = "Desired number of app instances in MIG"
  type        = number
  default     = 2
}

variable "mig_zones" {
  description = "Zones used by the regional MIG"
  type        = list(string)
  default     = ["europe-west1-b", "europe-west1-c"]
}

variable "app_machine_type" {
  description = "Machine type for app instances"
  type        = string
  default     = "e2-medium"
}

variable "app_boot_image" {
  description = "Boot image for app instances"
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "app_boot_disk_size_gb" {
  description = "Boot disk size (GB) for app instances"
  type        = number
  default     = 20
}

variable "app_boot_disk_type" {
  description = "Boot disk type for app instances"
  type        = string
  default     = "pd-balanced"
}

variable "db_instance_name" {
  description = "Name of the DB VM"
  type        = string
  default     = "db-vm-01"
}

variable "db_machine_type" {
  description = "Machine type for DB VM"
  type        = string
  default     = "e2-medium"
}

variable "db_boot_image" {
  description = "Boot image for DB VM"
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "db_boot_disk_size_gb" {
  description = "Boot disk size (GB) for DB VM"
  type        = number
  default     = 30
}

variable "db_boot_disk_type" {
  description = "Boot disk type for DB VM"
  type        = string
  default     = "pd-balanced"
}

variable "audit_instance_name" {
  description = "Name of the audit VM"
  type        = string
  default     = "audit-vm-01"
}

variable "audit_machine_type" {
  description = "Machine type for audit VM"
  type        = string
  default     = "e2-small"
}

variable "audit_boot_image" {
  description = "Boot image for audit VM"
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "audit_boot_disk_size_gb" {
  description = "Boot disk size (GB) for audit VM"
  type        = number
  default     = 20
}

variable "audit_boot_disk_type" {
  description = "Boot disk type for audit VM"
  type        = string
  default     = "pd-balanced"
}
