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

data "hcloud_image" "image" {
  with_selector = local.image_selector
  most_recent   = true
}

resource "hcloud_server" "server" {
  name        = var.server_name
  location    = var.server_location
  server_type = var.server_type

  image = data.hcloud_image.image.id
}

