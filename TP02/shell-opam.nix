{ nixpkgs ? import <nixpkgs> {} } :

let
  inherit (nixpkgs) pkgs;
in

pkgs.stdenv.mkDerivation {
  name = "my-ocaml-env";
  buildInputs = [
    pkgs.opam
    pkgs.rlwrap
    (pkgs.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
      # pkgs.dune_2
      # pkgs.ocamlformat
    ])))
    pkgs.vscode
  ];
}
