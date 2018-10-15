{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) wine wineUnstable wineStaging;

  wined3d = wine: wine.overrideDerivation (old: {
    name = "wined3d.dll";

    makeFlags = [ "dlls/wined3d" ];

    installPhase = ''
      install -D dlls/wined3d/wined3d.dll.so $out
    '';

    patches = [ ./ddraw-hack.patch ];
  });
in

{
  stable = wined3d wine;
  development = wined3d wineUnstable;
  staging = wined3d wineStaging;
}
