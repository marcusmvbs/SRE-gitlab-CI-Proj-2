resource "google_container_node_pool" "general" { # This node will be used for general purposes, running components like DNS
  name       = "general"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "general"
    }

    service_account = var.service_account_email
    oauth_scopes = [ 
        "https://www.googleapis.com/auth/cloud-platform" 
    ]
  }
}

resource "google_container_node_pool" "spot" { #spot machines are available based on demand. It is cheaper. Ideal for test
    name    = "spot"
    cluster = google_container_cluster.primary.id

    management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    labels = {
      team = "SRE"
    }

    taint { # it specifies the instance detail to be allocated
        key = "instance_type"
        value = "spot"
        effect = "NO_SCHEDULE"
    }

    service_account = var.service_account_email
    oauth_scopes = [ 
        "https://www.googleapis.com/auth/cloud-platform" 
    ]
  }
}