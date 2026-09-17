variable "azvnet" {
  type = object({
    name          = string
    address_space = string
  })
}

variable "resource_group" {
  type = object({
    location = string
    name     = string
  })
}

variable "subnetaks" {
  type = list(object({
    name             = string
    address_prefixes = string
    type             = string
  }))
}
