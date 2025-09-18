{
  description = "flakey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-maid.url = "github:viperML/nix-maid";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, nix-maid, yazi, ... }:

    let
    vars = import ./vars.nix;
  inherit (vars) USERNAME HOSTNAME TIMEZONE;
  in

  {
    nixosConfigurations.${HOSTNAME} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
          nix-maid.nixosModules.default
      ];
    };
    nixpkgs.overlays = [ yazi.overlays.default ];

  };
}
