output "vpc_name" {
  description = "Name of VPC"
  value       = module.test-vpc-module.network_name
}

output "vpc_self_link" {
  description = "Self link of VPC"
  value       = module.test-vpc-module.network_self_link
}

output "subnet_self_links" {
  description = "Subnet self links"
  value       = zipmap(module.test-vpc-module.subnets_names, module.test-vpc-module.subnets_self_links)
}

output "subnet_cidrs" {
  description = "Subnet CIDRs"
  value       = zipmap(module.test-vpc-module.subnets_names, module.test-vpc-module.subnets_ips)
}

output "subnet_regions" {
  description = "Subnet regions"
  value       = zipmap(module.test-vpc-module.subnets_names, module.test-vpc-module.subnets_regions)
}

output "subnets" {
  description = "Consolidated subnet information"
  value = {
    for i, name in module.test-vpc-module.subnets_names : name => {
      self_link = module.test-vpc-module.subnets_self_links[i]
      cidr      = module.test-vpc-module.subnets_ips[i]
      region    = module.test-vpc-module.subnets_regions[i]
    }
  }
}