variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "secondary_ranges" {
  description = "Secondary IP ranges for the subnet"
  type = map(object({
    range_name    = string
    ip_cidr_range = string
  }))
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