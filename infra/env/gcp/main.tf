
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.81.0"
    }
  }
}

locals {
  project = "master-324309"
  region  = "europe-north1" # Finland
  zone    = "europe-north1-c"
  net_range    = "10.2.0.0/28"
  net_range_k8s    = "10.3.0.0/16"
}

provider "google" {
    project = local.project
    region  = local.region # Finland
    zone    = local.zone 
}

module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "10.1.1"

  project_id                  = local.project

  activate_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "vpcaccess.googleapis.com",
    "run.googleapis.com",
    "container.googleapis.com"
  ]
}

resource "google_container_registry" "registry" {
  project = local.project
  location  = "EU"
}

resource "google_compute_network" "vpc_network" {
  project                 = local.project
  name                    = "vpc-network"
  auto_create_subnetworks = false

  depends_on = [
    module.project-services
  ]
}

resource "google_compute_firewall" "vpc_firewall" {
  name    = "benchmark-firewall-rule"
  project     = local.project

  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "8086", "8888"]
  }

  target_tags = ["benchmark"]
}

resource "google_compute_subnetwork" "subnet_master" {
  name          = "master-subnet"
  ip_cidr_range = local.net_range
  region        = local.region
  network       = google_compute_network.vpc_network.id
}

resource "google_vpc_access_connector" "cloudrun_connector" {
  provider      = google-beta
  name          = "cloudrun-connector"
  subnet {
    name = google_compute_subnetwork.subnet_master.name
  }
  project = local.project
  region     = local.region
}

# Influx + Jupiter ########################################################## 


data "google_compute_image" "vm_benckmark_image" {
  name = "cos-89-16108-470-16"
  project = "cos-cloud"
}

resource "google_compute_disk" "benchmark_disk" {
  name  = "benchmark-disk"
  project = local.project
  type  = "pd-ssd"
  size = 50
  zone  = local.zone
  image = data.google_compute_image.vm_benckmark_image.self_link
}

resource "google_compute_instance" "benchmark_machine" {
  name         = "benchmark-machine"
  machine_type = "c2-standard-4"
  zone         = local.zone

  tags = ["benchmark"]

  boot_disk {
    auto_delete = false
    source = google_compute_disk.benchmark_disk.self_link
  }

  metadata  = {
    google-logging-enabled = "false"
  }

  desired_status = "TERMINATED"  # "TERMINATED" or "RUNNING"

  network_interface {
    #network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet_master.self_link

    access_config {
      // Ephemeral public IP
    }
  }

  network_interface {
    network = "default"
    #subnetwork = google_compute_subnetwork.subnet_master_k8s.self_link
  }

  metadata_startup_script = "docker rmi $(docker images -a -q) || true && docker run --rm --name bench_machine -v /var/run/docker.sock:/var/run/docker.sock engisaacnewton/bench_machine:latest"

}

