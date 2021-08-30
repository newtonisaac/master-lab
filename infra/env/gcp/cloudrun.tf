
# Cloud Run ########################################################## Default service: node

module "node_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "node"
  image = "eu.gcr.io/${local.project}/servelessbench:node"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}

######################################################### service: node1g

module "node1g_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "node1g"
  memory = "1024Mi"
  cpu = "1000m"
  image = "eu.gcr.io/${local.project}/servelessbench:node"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}

#########################################################  service: node2g

module "node2g_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "node2g"
  memory = "2048Mi"
  cpu = "2000m"
  image = "eu.gcr.io/${local.project}/servelessbench:node"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}

#########################################################  python

module "python_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "python"
  image = "eu.gcr.io/${local.project}/servelessbench:python"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}

#########################################################  php

module "php_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "php"
  image = "eu.gcr.io/${local.project}/servelessbench:php"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}

#########################################################  java

module "java_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "java"
  image = "eu.gcr.io/${local.project}/servelessbench:java"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}


#########################################################  go

module "go_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "go"
  image = "eu.gcr.io/${local.project}/servelessbench:go"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}


#########################################################  csharp

module "csharp_cloud_run_service" {
  source = "./cloud_run_service"

  project = local.project
  region = local.region 
  
  name = "csharp"
  image = "eu.gcr.io/${local.project}/servelessbench:csharp"
  cloudrun_connector_id = google_vpc_access_connector.cloudrun_connector.id
  scale_to_zero = true
}