resource "google_compute_subnetwork" "private" {
  name                = "private"
  ip_cidr_range       = "10.0.0.0/18" # Nodes uses primary range of IPs
  region              = "us-central1"
  network             = google_compute_network.vpc.id # reference to the vpc created
  private_ip_google_access = true

  secondary_ip_range {
    range_name = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14" # Pods uses secondary range of IPs
  }

  secondary_ip_range {
    range_name = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20" 
  }
}