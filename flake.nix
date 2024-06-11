{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    ,
    }:
    utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      mdbook-typst-doc = pkgs.rustPlatform.buildRustPackage rec {
        pname = "mdbook-typst-doc";
        version = "0.1.2";

        src = pkgs.fetchFromGitHub {
          owner = "fenjalien";
          repo = pname;
          rev = version;
          sha256 = "sha256-GulEn/MSiE8su0k+VL3uNslYCbjLJnmW6rMOdTQSMUw=";
        };

        cargoHash = "sha256-KD6J8dTIPaII4ISh0PW6u1EMj5JVEDYcXuZ75ycbSys=";
      };
      typstyle = pkgs.rustPlatform.buildRustPackage rec {
        pname = "typstyle";
        version = "v0.11.25";

        src = pkgs.fetchFromGitHub {
          owner = "Enter-tainer";
          repo = pname;
          rev = version;
          sha256 = "sha256-wpG+laz1k/zCnEAVOyXzrN2DOECpKWT1nVCuQUwD+p0=";
        };

        nativeBuildInputs = [
          pkgs.pkg-config
        ];


        checkFlags = [
          "--skip=e2e"
        ];
        cargoHash = "sha256-+8nadPuRKNKM+YVzZlz9rypDKjorYIwTUYkaSFrra1k=";
      };
    in
    {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          typst

          nodePackages_latest.prettier
          just
          mdbook
          mdbook-admonish

          mdbook-typst-doc
          typstyle
        ];
      };

    });
}
