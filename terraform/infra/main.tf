
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

# Enviroment modules

module "local" {
  source = "./env/local"
}
