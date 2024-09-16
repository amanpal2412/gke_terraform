resource "google_monitoring_alert_policy" "gke_cpu_utilization" {
  display_name = "GKE Node CPU Utilization Alert"

  conditions {
    display_name = "CPU Utilization of GKE Nodes"
    condition_threshold {
      filter = "metric.type=\"kubernetes.io/node/cpu/allocatable_utilization\" AND resource.type=\"k8s_node\" AND resource.label.\"cluster_name\"=\"${var.cluster_name}\""

      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_PERCENT_CHANGE"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.instance_id"]
      }

      comparison = "COMPARISON_GT"
      duration   = "300s"
      threshold_value = 80
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.id
  ]

  combiner = "OR"
}

resource "google_monitoring_alert_policy" "gke_memory_utilization" {
  display_name = "GKE Node Memory Utilization Alert"

  conditions {
    display_name = "Memory Utilization of GKE Nodes"
    condition_threshold {
      filter = "metric.type=\"kubernetes.io/node/memory/allocatable_utilization\" AND resource.type=\"k8s_node\" AND resource.label.\"cluster_name\"=\"${var.cluster_name}\""

      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_PERCENT_CHANGE"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.instance_id"]
      }

      comparison = "COMPARISON_GT"
      duration   = "300s"
      threshold_value = 80
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.id
  ]

  combiner = "OR"
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notification Channel"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}
