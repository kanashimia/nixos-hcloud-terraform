variable "server_location" {
  type    = string
  default = null
}

variable "server_type" {
  type = string
}

variable "server_name" {
  type = string
}

variable "image_selector" {
  type    = string
  default = null
}

locals {
  image_selector = var.image_selector != null ? var.image_selector : "snapshot_name=${var.server_name}"
}

output "ipv4_address" {
  value = hcloud_server.server.ipv4_address
}

output "ipv6_address" {
  value = hcloud_server.server.ipv6_address
}
