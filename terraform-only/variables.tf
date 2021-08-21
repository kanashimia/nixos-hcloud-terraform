variable "location" {
  type    = string
  default = "nbg1"
}

variable "server_type" {
  type    = string
  default = "cx11"
}

variable "server_name" {
  type    = string
  default = "personal-server"
}

variable "nixos_flake_ref" {
  type    = string
  default = "path:/home/kanashimia/nixos"
}

variable "flake_output" {
  type    = string
  default = "personal-server"
}

variable "part_scheme" {
  type    = string
  default = <<-EOF
    label: mbr
    type=83 bootable
  EOF
}
