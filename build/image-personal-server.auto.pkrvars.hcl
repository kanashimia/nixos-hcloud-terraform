snapshot_name = "personal-server"

server_location = "nbg1"
server_type     = "cx11"

image_flake_ref = "github:kanashimia/nixos#personal-server"

image_part_scheme = <<-EOF
  label: mbr
  type=83 bootable
EOF
