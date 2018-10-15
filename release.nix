{ pkgs ? import <nixpkgs> {} }: with pkgs;

let
  wined3d = import ./. { inherit pkgs; };

  wineVersion = wine: wine.overrideDerivation (old: {
    name = "wine-version.txt";

    configurePhase = ":";
    buildPhase = ":";
    installPhase = "cp VERSION $out";
  });
in

runCommand "wined3d-release" {} ''
  mkdir -p $out/{stable,development,staging}

  ln -s ${wined3d.stable} $out/stable/wined3d.dll
  ln -s ${wineVersion wined3d.stable} $out/stable/version.txt

  ln -s ${wined3d.development} $out/development/wined3d.dll
  ln -s ${wineVersion wined3d.development} $out/development/version.txt

  ln -s ${wined3d.staging} $out/staging/wined3d.dll
  ln -s ${wineVersion wined3d.staging} $out/staging/version.txt
''
