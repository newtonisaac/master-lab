terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.9.0"
    }
  }
  backend "local" {
    path = ".state/terraform.tfstate"
  }
}

provider "docker" {
  host = "tcp://localhost:2376"
}

resource "docker_image" "dind-kind_image" {
  name = "dind-kind"
  keep_locally = true
  build {
    path = "./images/dind-kind/"
    tag = ["v1"]
  }
}

resource "docker_container" "dind-kind-container" {
  image = docker_image.dind-kind_image.latest 
  name  = "dind-kind-container"
  hostname = "dind-kind"
  network_mode = "host"
  privileged = true
  mounts {
    target = "/var/run/docker.sock"
    source = "/var/run/docker.sock"
    type = "bind"
  }

  provisioner "local-exec" {
    command = "sh ./scripts/init_dind-kind.sh ${docker_container.dind-kind-container.id}"
  }
}

      
# resource "docker_image" "boundary_image" {
#   name = "boundary_image"
#   keep_locally = true
#   build {
#     path = "./images/boundary/"
#     tag = ["v1"]
#   }
# }

# resource "docker_container" "boundary-container" {
#   image = docker_image.boundary_image.latest
#   name  = "boundary-container"
#   hostname = "boundary"
#   network_mode = "host"
#   privileged = true
# }


# resource "null_resource" "boundary-container" {
#   provisioner "local-exec" {
#     command = "sh ./scripts/await_boundary.sh"
#   }
#   depends_on = [ docker_container.boundary-container, docker_container.dind-kind-container ]
# }