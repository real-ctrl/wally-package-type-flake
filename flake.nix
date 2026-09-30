{
  description = "Flake for wally package types CLI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = {
        wally-package-types = pkgs.stdenv.mkDerivation {
            pname = "wally-package-types";
            version = "1.7.0";

            nativeBuildInputs = [
            pkgs.autoPatchelfHook
            pkgs.unzip
            ];

            buildInputs = [
            pkgs.zlib
            pkgs.libgcc
            ];

            src = pkgs.fetchzip {
            url = "https://github.com/JohnnyMorganz/wally-package-types/releases/download/v1.7.0/wally-package-types-linux-x86_64.zip";
            sha256 = "sha256-HXmXiWNQVagrDQQ1720hq1NT620x9DsYgXhWi5yY4Vw=";
            stripRoot = false;
            };

            installPhase = ''
            mkdir -p $out/bin
            cp wally-package-types $out/bin/wally-package-types
            chmod +x $out/bin/wally-package-types
            '';
        };

        
      };

      defaultPackage.${system} = self.packages.${system}.wally-package-types;
    };
}