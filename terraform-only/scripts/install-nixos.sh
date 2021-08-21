#!/bin/sh -e

echo Installing Nix...

apt-get -qq install sudo
mkdir /nix

addgroup --system --gid 30000 nixbld
for i in $(seq 1 32); do
    useradd --home-dir /var/empty --gid nixbld --groups nixbld --no-create-home --no-user-group --system --shell /usr/sbin/nologin --uid $((30000 + i)) nixbld$i
done

curl -Ls https://nixos.org/nix/install | sh

. /root/.nix-profile/etc/profile.d/nix.sh

echo Adding channels...
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update

echo Updating Nix...
nix-env --quiet -f '<nixpkgs>' -iA nixUnstable nixos-install-tools

echo Installing NixOS...
TERM=dumb nixos-install --flake "$FLAKE_REF" --no-root-passwd
