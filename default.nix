{ pkgs ? import <nixpkgs> {} }:

with pkgs;

callPackage ./wined3d.nix {
  wine = wineUnstable;
}
