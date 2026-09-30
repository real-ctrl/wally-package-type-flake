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
      packages.${system}.wally-package-types = pkgs.stdenv.mkDerivation {
        pname = "wally-package-types";
        version = "1.7.0";

        nativeBuildInputs = [
          pkgs.autoPatchelfHook
          pkgs.unzip
        ];

        buildInputs = [
          pkgs.zlib
          pkgs.openssl_3
          pkgs.libgcc
        ];

        src = pkgs.fetchzip {
          url = "https://github.com/JohnnyMorganz/wally-package-types/releases/download/v1.7.0/wally-package-types-linux-x86_64.zip";
          sha256 = "sha256-a8ce418b45a04dec8cce321a4f3583fe20b448e6c2c31c71aa453f590051911b";
          stripRoot = false;
        };

        installPhase = ''
          mkdir -p $out/bin
          cp $src/wally-package-types $out/bin/wally-package-types
          chmod +x $out/bin/wally-package-types
        '';
      };

      defaultPackage.${system} = self.packages.${system}.wally-package-types;
    };
}