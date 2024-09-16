variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
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
  description = "The service account ID for the nodes"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "secondary_ranges" {
  description = "Secondary IP ranges for the subnet"
  type = map(object({
    range_name    = string
    ip_cidr_range = string
  }))
}

variable "alert_email" {
  description = "Email for sending the alert"
  type        = string
}