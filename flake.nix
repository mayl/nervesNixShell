{
  description = "An elixir devshell";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mixOverlay = {
      url = "github:hauleth/nix-elixir";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, mixOverlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ (import mixOverlay) ];
          };
        in
        {
          devShell = import ./buildrootNervesFHS.nix { inherit pkgs; };
        }
      );
}
