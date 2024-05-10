resource "google_container_cluster" "primary" { 
  name                     = "primary"
  location                 = "us-central1-a" # created only in one region due to budget
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  logging_service          = "logging.googleapis.com/kubernetes"    # fluentd agent to scrape all the logs
  monitoring_service       = "monitoring.googleapis.com/kubernetes" # Disable monitoring_service if using prometheus
  networking_mode          = "VPC_NATIVE"

  # Regional Cluster (control plane): 99.95% SLA - Downtime per month ~21.92 minutes
  # AZ cluster config - Dual zone for this project
  node_locations = [
      "us-central1-b"
  ]

  addons_config { 
    http_load_balancing {
      disabled = true  # Disabled to use nginx controller
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR" # k8s cluster upgrade management
  }

  workload_identity_config {
    workload_pool = "pioneering-rex-394919.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false # VPN and Bastion Host setups disabled
    master_ipv4_cidr_block  = "172.16.0.0/28" # IP from google, control plane is managed by them
  }
}