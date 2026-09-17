variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}


variable "subnet_id" {
  type = string
}

variable "aks" {
  type = object({
    name           = string
    dns_prefix     = string
    node_pool_name = string
    node_count     = number
    vm_size        = string
    service_cidr   = string
    dns_service_ip = string
  })
}
