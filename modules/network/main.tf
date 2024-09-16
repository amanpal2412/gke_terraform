resource "google_compute_network" "vpc" {
  name                            = var.vpc_name
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
}

resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region_router
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}

resource "google_compute_router" "router" {
  name    = "kube-router-tf"
  region  = var.region_router
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  name   = "kube-nat-tf"
  router = google_compute_router.router.name
  region = var.region_router

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = var.network_tier
}

resource "google_compute_firewall" "allow-ssh" {
  name    = var.firewall_name
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}