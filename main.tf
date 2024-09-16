module "network" {
  source           = "./modules/network"
  vpc_name         = var.vpc_name
  subnet_name      = var.subnet_name
  subnet_cidr      = var.subnet_cidr
  secondary_ranges = var.secondary_ranges
  region_router    = var.region_router
  network_tier     = var.network_tier
  firewall_name    = var.firewall_name
}

module "gke" {
  source             = "./modules/gke"
  project_id         = var.project_id
  region             = var.region
  cluster_name       = var.cluster_name
  env_name           = var.env_name
  node_pool_name     = var.node_pool_name
  node_count         = var.node_count
  machine_type       = var.machine_type
  disk_size_gb       = var.disk_size_gb
  service_account_id = var.service_account_id
  vpc_id             = module.network.vpc_id
  subnet_id          = module.network.subnet_id
  secondary_ranges   = var.secondary_ranges
  alert_email        = var.alert_email
}