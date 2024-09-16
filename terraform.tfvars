project_id  = "xyz-tf"
region      = "us-central1"
vpc_name    = "kube-vpc-tf"
subnet_name = "kube-private-subnet-tf"
subnet_cidr = "10.0.0.0/18"
secondary_ranges = {
  k8s_pod_range = {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  },
  k8s_service_range = {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}
cluster_name       = "kube-cluster-tf"
node_pool_name     = "kube-pool"
node_count         = 1
machine_type       = "e2-medium"
disk_size_gb       = 30
service_account_id = "kubernetes"
bucket_name        = "backend_bucket_tf"
bucket_prefix      = "terraform/state"
region_router      = "us-central1"
network_tier       = "PREMIUM"
firewall_name      = "kube-allow-ssh-tf"
alert_email        = "itspalaman@gmail.com"