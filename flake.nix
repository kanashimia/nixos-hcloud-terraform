{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system}; {
        devShell = mkShell {
          buildInputs = [ terraform packer ];
          shellHook = ''
            export HCLOUD_TOKEN="$(systemd-ask-password HCLOUD_TOKEN:)"
          '';
        };
      }
    );
}

