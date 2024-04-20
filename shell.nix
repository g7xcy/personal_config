{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # add packages here
    ];
  shellHook = ''
    echo "use nix" > .envrc
  '';
}

