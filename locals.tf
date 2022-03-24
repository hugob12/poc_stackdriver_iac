data "google_project" "project" {}

locals {
  project                         = "i-dss-ingest-dev"
  project_number                  = data.google_project.project.number
  region                          = "us-central1"
  zones                           = ["us-central1-f", "us-central1-c"]
  main_zone                       = local.zones[0]
  ingest_service_account          = format("ingestdev@%s.iam.gserviceaccount.com", local.project)
  secondary_region                = "us-east1"
  secondary_zones                 = ["us-east1-d", "us-east1-c"]
  compute_default_service_account = "${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

// The project GSA used by Storage service to publish to pubsub
data "google_storage_project_service_account" "gcs_account" {
}


