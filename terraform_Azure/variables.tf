variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "azvnet" {
  type = object({
    name          = string
    address_space = string
  })
}

variable "subnetaks" {
  type = list(object({
    name             = string
    address_prefixes = string
    type             = string
  }))
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

variable "aks" {
  type = object({
    name           = string
    dns_prefix     = string
    node_count     = number
    node_pool_name = string
    vm_size        = string
    service_cidr   = string
    dns_service_ip = string
  })
}
