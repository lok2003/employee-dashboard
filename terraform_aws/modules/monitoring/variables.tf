variable "eks_cluster" {
  type = string
}

variable "log_retention" {
  type = object({
    days = number
  })
}

variable "alerts_email" {
  type = string
}

