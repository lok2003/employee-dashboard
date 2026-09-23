resource "aws_ecr_repository" "frontend_ecr" {
  name                 = var.ecr.frontend_name
  image_tag_mutability = var.ecr.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_repository" "backend_ecr" {
  name                 = var.ecr.backend_name
  image_tag_mutability = var.ecr.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = true
  }
}
