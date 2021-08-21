terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

# Fetch NixOS config, so we can b local and remote.
data "external" "nixos_flake_source" {
  program = [ "nix", "flake", "prefetch", "--json", var.nixos_flake_ref ]
}

resource "hcloud_ssh_key" "ssh_key" {
  name       = "hp-laptop"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "hcloud_server" "nixos_server" {
  name        = var.server_name

  # We install from a rescue system, so the image doesn't matter.
  image       = "debian-11" 
  rescue      = "linux64"

  location    = var.location
  server_type = var.server_type

  ssh_keys    = [ resource.hcloud_ssh_key.ssh_key.id ]

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.ipv4_address
    private_key = file("~/.ssh/id_ed25519")
  }

  # File provisioner is too stupid, so we need to make some help.
  provisioner "remote-exec" {
    inline = [ "mkdir /root/nixos" ]
  }

  # Trailing slash is required to copy dir contents instead of a dir itself.
  provisioner "file" {
    destination = "/root/nixos"
    source      = "${data.external.nixos_flake_source.result.storePath}/"
  }

  provisioner "file" {
    destination = "/root/part_scheme"
    content     = var.part_scheme
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/format-drive.sh",
      "scripts/install-nixos.sh",
      "scripts/reboot.sh",
    ]
  }
}
