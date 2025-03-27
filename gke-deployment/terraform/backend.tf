terraform {
  backend "gcs" {
    bucket = "python-api-app-tf-state-staging"
    prefix = "terraform/state"
  }
}
