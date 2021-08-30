resource "google_container_cluster" "k8s_cluster_master_knative" {
  name               = "k8s-master-cluster-knative"
  project = local.project
  location = local.region 
  
  min_master_version = "1.20"
  network    = "default"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  depends_on = [
    module.project-services
  ]
}


resource "google_container_node_pool" "master_node_pool" {
  name       = "master-node-pool"
  cluster    = google_container_cluster.k8s_cluster_master_knative.id
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium" # 2 cpu, 4G RAM 

    tags = [ "k8s-node" ]
  }

}