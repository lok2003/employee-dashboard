variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "acr" {
  type = object({
    frontend_name = string
    backend_name  = string
    sku           = string
    admin_enabled = bool
  })
}
