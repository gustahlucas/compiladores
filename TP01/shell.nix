{ nixpkgs ? import <nixpkgs> {} } :

let
  inherit (nixpkgs) pkgs;
  ocamlPackages = pkgs.ocamlPackages;
  # ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_11;
  #ocamlPackages = pkgs.ocamlPackages_latest;
in

pkgs.stdenv.mkDerivation {
  name = "my-ocaml-env";
  buildInputs = [
    ocamlPackages.dune_2
    ocamlPackages.findlib # essential
    ocamlPackages.ocaml
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    ocamlPackages.ppx_expect
    ocamlPackages.alcotest
    ocamlPackages.ptime

    pkgs.rlwrap

    (pkgs.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
      ocamlPackages.dune_2
    ])))

    pkgs.vscode
  ];
}
