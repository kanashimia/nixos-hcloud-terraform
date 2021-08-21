terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  backend "local" {
    path = ".terraform.tfstate"
  }
}

data "hcloud_image" "nixos_snapshot" {
  with_selector = "snapshot_name=${var.snapshot_name}"
  most_recent   = true
}

resource "hcloud_server" "nixos_server" {
  name        = var.snapshot_name
  location    = var.location
  server_type = var.server_type

  image = data.hcloud_image.nixos_snapshot.id
}

