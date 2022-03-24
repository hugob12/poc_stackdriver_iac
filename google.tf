provider "google" {
  project = local.project
  region  = local.region
}

provider "google-beta" {
  project = local.project
  region  = local.region
}
