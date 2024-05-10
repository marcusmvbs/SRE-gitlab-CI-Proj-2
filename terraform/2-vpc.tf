# Resource to be able to create a VPC
resource "google_project_service" "compute" { 
  service = "compute.googleapis.com"
}

# Resource to create a Kubernetes cluster
resource "google_project_service" "container" { 
  service = "container.googleapis.com"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "vpc" {
  name                            = "vpc"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460 # Max transmission unit (bytes)
  delete_default_routes_on_create = false
  
  depends_on = [ google_project_service.compute,
                 google_project_service.container
  ]
}