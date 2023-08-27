/*
resource "google_service_account" "service-a" {
    account_id = "service-a"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "service-a" {
    project = "pioneering-rex-394919"
    role    = "roles/storage.admin"
    member  = "serviceAccount:${google_service_account.service-a.email}"
}

resource "google_service_account_iam_member" "service-a" { # it allows k8s service account to impersonate this GCP service account (k8s RBAC - GCP IAM link)
    service_account_id = google_service_account.service-a.id
    role               = "roles/iam.workloadIdentityUser"
    member             = "serviceAccount:${pioneering-rex-394919.svc.id.goog[staging/service-a]}" #[namespace / k8s service account]
}
*/