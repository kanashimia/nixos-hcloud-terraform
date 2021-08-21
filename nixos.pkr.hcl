source "hcloud" "nixos_server" {
  server_name = "${var.snapshot_name}-builder"

  snapshot_name = "${var.snapshot_name}-${timestamp()}"
  snapshot_labels = {
    snapshot_name = var.snapshot_name
  }

  image  = "debian-11"
  rescue = "linux64"

  server_type = var.server_type
  location    = var.location

  ssh_username = "root"
}

build {
  sources = ["source.hcloud.nixos_server"]

  provisioner "shell" {
    environment_vars = [
      "FLAKE_REF=${var.flake_ref}",
      "PART_SCHEME=${var.part_scheme}",
    ]
    scripts = [
      "scripts/format-drive.sh",
      "scripts/install-nixos.sh",
    ]
  }
}
