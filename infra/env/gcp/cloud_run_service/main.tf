data "google_iam_policy" "data_policy_noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service" "cr_service" {
  name     = var.name
  project  = var.project
  location = var.region
  template {
    spec {
      containers {
        image = var.image
        resources {
            limits = {
                cpu = var.cpu
                memory = var.memory
            }
            requests = {
                cpu = var.cpu
                memory = var.memory
            }
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = var.scale_to_zero ? 0 : 1
        "run.googleapis.com/vpc-access-egress" = "private-ranges-only"
        "autoscaling.knative.dev/maxScale" = 100
        "run.googleapis.com/vpc-access-connector" = var.cloudrun_connector_id
      }
    }
  }
  
  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal"
    }
  }
}

resource "google_cloud_run_service_iam_policy" "srv_policy_noauth" {
  location    = google_cloud_run_service.cr_service.location
  project     = google_cloud_run_service.cr_service.project
  service     = google_cloud_run_service.cr_service.name

  policy_data = data.google_iam_policy.data_policy_noauth.policy_data
}
