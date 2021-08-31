
# Enviroment modules

module "local" {
  source = "./env/local"
}

module "gcp" {
  source = "./env/gcp"
}

module "aws" {
  source = "./env/aws"
}
