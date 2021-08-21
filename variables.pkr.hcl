variable "location" {
  type    = string
  default = "nbg1"
}

variable "server_type" {
  type    = string
  default = "cx11"
}

variable "snapshot_name" {
  type    = string
  default = "personal-server"
}

variable "flake_ref" {
  type    = string
  default = "github:kanashimia/nixos#personal-server"
}

variable "part_scheme" {
  type    = string
  default = <<-EOF
    label: mbr
    type=83 bootable
  EOF
}
