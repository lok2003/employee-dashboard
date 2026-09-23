variable "ecr" {
  type = object({
    frontend_name        = string
    backend_name         = string
    image_tag_mutability = string
  })
}
