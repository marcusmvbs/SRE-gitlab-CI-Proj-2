# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    credentials = "../creds/service_account.json"
    bucket      = "tf-state-bucket-mvb"
  }
  required_providers {
    google    = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}