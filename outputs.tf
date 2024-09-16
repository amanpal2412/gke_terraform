output "network" {
  description = "The VPC network"
  value       = module.network.vpc_id
}

output "subnetwork" {
  description = "The VPC subnetwork"
  value       = module.network.subnet_id
}

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = module.gke.cluster_name
}