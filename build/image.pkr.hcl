source "hcloud" "server" {
  server_name = "${var.snapshot_name}-builder"

  snapshot_name = "${var.snapshot_name}-${timestamp()}"
  snapshot_labels = {
    snapshot_name = var.snapshot_name
  }

  image  = "debian-11"
  rescue = "linux64"

  server_type = var.server_type
  location    = var.server_location

  ssh_username = "root"
}

build {
  sources = ["source.hcloud.server"]

  provisioner "shell" {
    environment_vars = [
      "FLAKE_REF=${var.image_flake_ref}",
      "PART_SCHEME=${var.image_part_scheme}",
    ]
    scripts = [
      "scripts/format-drive.sh",
      "scripts/install-nixos.sh",
    ]
  }
}
