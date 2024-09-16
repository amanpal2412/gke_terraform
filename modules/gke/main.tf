resource "google_container_cluster" "cluster" {
  name                     = "${var.cluster_name}-${var.env_name}"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_id
  subnetwork               = var.subnet_id
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  deletion_protection      = false

  node_locations = [
    "us-central1-a",
    "us-central1-b"
  ]

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.secondary_ranges.k8s_pod_range.range_name
    services_secondary_range_name = var.secondary_ranges.k8s_service_range.range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}

resource "google_service_account" "kubernetes_1" {
  account_id = var.service_account_id
}

resource "google_container_node_pool" "node_pool" {
  name       = var.node_pool_name
  cluster    = google_container_cluster.cluster.id
  node_count = var.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb

    labels = {
      team = "devops"
    }

    service_account = google_service_account.kubernetes_1.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}