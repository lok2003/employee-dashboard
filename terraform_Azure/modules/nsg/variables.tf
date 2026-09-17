variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "nsg" {
  type = object({
    name = string
  })
}

variable "rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "subnet_id" {
  type = string
}