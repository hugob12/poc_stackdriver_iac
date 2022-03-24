
resource "google_monitoring_notification_channel" "email0" {
  display_name = "Hugo Blanco"
  type = "email"
  labels = {
    email_address = "hugo.blanco@cbsinteractive.com"
  }
}



locals {

  email0_id = "${google_monitoring_notification_channel.email0.name}"
}

resource "google_monitoring_alert_policy" "alert_policy0" {
  display_name = "Airflow-Worker-Restart"
  combiner = "OR"
  conditions {
    display_name = "Restart count for i-dss-ingest-dev"
    condition_threshold {
      filter = "resource.type = \"k8s_container\" AND resource.labels.cluster_name = \"us-central1-iflow-dev-zzk7-93b79581-gke\" AND metric.type = \"kubernetes.io/container/restart_count\""

      duration = "3600s"
      comparison = "COMPARISON_GT"
      threshold_value = 1
      trigger {
          count = 1
      }
      aggregations {
        alignment_period = "3600s"
        cross_series_reducer = "REDUCE_SUM"
        per_series_aligner = "ALIGN_DELTA"
        group_by_fields = [ "resource.label.pod_name" ]
      }

    }

  }

  alert_strategy {
		     auto_close = "604800s"
      }
  documentation {
    content = "The load balancer rule $${condition.display_name} has generated this alert for the $${metric.display_name}."
  }
  notification_channels = [
      "${local.email0_id}",

  ]

}

