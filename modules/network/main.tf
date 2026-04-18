module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 16.0"
  project_id   = var.project_id
  network_name = "my-custom-mode-network"

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
      description   = "App subnet"
    },
    {
      subnet_name   = "subnet-02"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "europe-west1"
      purpose       = "REGIONAL_MANAGED_PROXY"
      role          = "ACTIVE"
      description   = "Internal HTTP load balancer proxy-only subnet"
    },
    {
      subnet_name   = "subnet-03"
      subnet_ip     = "10.10.30.0/24"
      subnet_region = "europe-west1"
      description   = "Internal HTTP load balancer frontend subnet"
    },
    {
      subnet_name           = "subnet-04"
      subnet_ip             = "10.10.40.0/24"
      subnet_region         = "europe-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
      description           = "DB subnet"
    },
    {
      subnet_name               = "subnet-05"
      subnet_ip                 = "10.10.50.0/24"
      subnet_region             = "europe-west1"
      subnet_flow_logs          = true
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter   = false
      description               = "Audit subnet"
    }
  ]
}