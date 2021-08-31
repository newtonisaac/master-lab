resource "aws_ecr_repository" "master_registry" {
  name                 = "servelessbench"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}