variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR range for the subnet"
  type        = string
}

variable "secondary_ranges" {
  description = "Secondary IP ranges for the subnet"
  type = map(object({
    range_name    = string
    ip_cidr_range = string
  }))
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "dev"
}

variable "node_pool_name" {
  description = "The name of the node pool"
  type        = string
}
variable "node_count" {
  description = "The number of nodes in the node pool"
  type        = number
}
variable "machine_type" {
  description = "The machine type for the nodes"
  type        = string
}
variable "disk_size_gb" {
  description = "The disk size for the nodes"
  type        = number
}

variable "service_account_id" {
  description = "The ID of the service account to use"
  type        = string
}

variable "bucket_name" {
  description = "The GCS bucket for Terraform state"
  type        = string
}
variable "bucket_prefix" {
  description = "The prefix in the GCS bucket for Terraform state"
  type        = string
}
variable "region_router" {
  description = "Region for the router and NAT"
  type        = string
}
variable "network_tier" {
  description = "The network tier for the NAT IP address"
  type        = string
}
variable "firewall_name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "alert_email" {
  description = "The email to send the threshold alerts"
  type        = string
}