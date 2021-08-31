terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.56.0"
    }
  }
}

locals {
  region = "eu-north-1"
  az_count = 3
}

provider "aws" {
  region = local.region
}


resource "aws_ecs_cluster" "master_fargate_cluster" {
  name = "master-fargate-cluster"
}

module "master_ecs" {
    source = "./modules/ecs"

    aws_region = local.region 
    ecs_task_execution_role_name = "ecsTaskExecutionRole"
    az_count = local.az_count
    cluster_id = aws_ecs_cluster.master_fargate_cluster.id
    cluster_name = aws_ecs_cluster.master_fargate_cluster.name

    app_image = "${aws_ecr_repository.master_registry.repository_url}:node"
    app_port = 8080
    app_count = "1"
    health_check_path = "/"
    fargate_cpu = "512"
    fargate_memory = "1024"

}