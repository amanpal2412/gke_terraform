# terraform {
#   backend "gcs" {
#     bucket = var.bucket_name
#     prefix = var.bucket_prefix
#   }
# }

terraform {
  backend "gcs" {
    bucket = "backend_bucket_tf"
    prefix = "terraform/state"
  }
}

provider "google" {
  # credentials = file("<path/to/your/google-credentials.json>")
  project = var.project_id
  region  = var.region
}