
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.9.0"
    }
    boundary = {
      source = "hashicorp/boundary"
      version = "0.1.0"
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

# module "boundary" {
#   source = "./env/shared/boundary"
#   boundary_addrs                    = module.local.boundary_addrs
#   auth_method_id                    = module.local.auth_method_id
#   password_auth_method_login_name   = module.local.password_auth_method_login_name
#   password_auth_method_password     = module.local.password_auth_method_password

#   depends = [ module.local.module_name ]
# }