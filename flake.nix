{
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.cargo2nix = {
    url = "github:cargo2nix/cargo2nix/release-0.11.0";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-compat.follows = "flake-compat";
    inputs.flake-utils.follows = "flake-utils";
  };
  outputs = { nixpkgs, flake-utils, cargo2nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlays.default ];
        };
        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.75.0";
          packageFun = import ./Cargo.nix;
          extraRustComponents = [ "clippy" ];
        };
      in
      {
        packages.default = rustPkgs.workspace.comment { };
        devShells.default = rustPkgs.workspaceShell {
          packages = [ pkgs.rust-analyzer ];
        };
        apps.generateCargoNix = {
          type = "app";
          program =
            pkgs.lib.getExe (pkgs.writeShellApplication
              {
                name = "generateCargoNix";
                runtimeInputs = [ cargo2nix.packages.${system}.default ];
                text = ''
                  cargo2nix . --overwrite --locked
                '';
              });
        };
      }
    );
}
