
# Enviroment modules

module "local" {
  source = "./env/local"
}

module "gcp" {
  source = "./env/gcp"
}

output "result" {
  value = module.gcp.result
}
