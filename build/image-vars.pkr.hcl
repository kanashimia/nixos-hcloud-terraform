variable "server_location" {
  type    = string
  default = null
}

variable "server_type" {
  type = string
}

variable "snapshot_name" {
  type    = string
  default = null
}

variable "image_flake_ref" {
  type = string
}

variable "image_part_scheme" {
  type = string
}
