#!/bin/sh -e

echo Installing Nix...

DEBIAN_FRONTEND=noninteractive apt-get -qq install sudo
mkdir /nix

addgroup --system --gid 30000 nixbld
for n in $(seq 1 32); do
    useradd -MNr -d /var/empty -g nixbld -G nixbld -s "$(which nologin)" nixbld$n
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
