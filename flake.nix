{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    typst.url = "github:typst/typst/main";
    typstfmt.url = "github:astrale-sharp/typstfmt";

    typst.inputs.nixpkgs.follows = "nixpkgs";
    typstfmt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    , typst
    , typstfmt
    ,
    }:
    utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell = pkgs.mkShell {
        packages = [
          typst.packages.${system}.default
          pkgs.typst-lsp
          typstfmt.packages.${system}.default
          pkgs.act
          pkgs.nodePackages_latest.prettier
          pkgs.pre-commit
        ];
      };

      packages.default = with pkgs;
        stdenv.mkDerivation {
          name = "notebook";
          postConfigurePhase = ''
            # mkdir -p src/fonts
            # ln -s ${font-awesome}/share/fonts/opentype/* src/fonts/
            # ln -s ${roboto}/share/fonts/truetype/* src/fonts/
            # ln -s ${source-sans-pro}/share/fonts/truetype/* src/fonts/
            # ln -s ${jetbrains-mono}/share/fonts/truetype/* src/fonts/
            # ln -s ${nerdfonts.override {fonts = ["JetBrainsMono"];}}/share/fonts/truetype/* src/fonts/
          '';

          buildCommand = ''
            mkdir $out
            # ${typst}/bin/typst --font-path "${self}/src/fonts" compile ${self}/main.typ $out/main.pdf
            ${typst}/bin/typst --font-path "${nerdfonts}/share/fonts/truetype/" fonts
            ${typst}/bin/typst --font-path "${nerdfonts}/share/fonts/truetype/"  compile ${self}/main.typ $out/main.pdf
          '';
        };
    });
}
