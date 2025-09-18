{ stdenv }:

stdenv.mkDerivation {
  name = "kokomiIcon";

  # use the local tarball directly
  src = ./pkgs/Kokomi.tar.gz;

  installPhase = ''
    mkdir -p $out/share/icons/Kokomi_Cursor
    cp -r ./* $out/share/icons/Kokomi_Cursor
  '';
}

