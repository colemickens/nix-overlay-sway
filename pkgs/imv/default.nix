{ stdenv, fetchFromGitHub
, freeimage, fontconfig, pkgconfig
, asciidoc, docbook_xsl, libxslt, cmocka
, librsvg, pango, libxkbcommon, wayland
, libGLU, icu
}:

let metadata = import ./metadata.nix; in
stdenv.mkDerivation rec {
  pname = "imv";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner  = "eXeC64";
    repo   = "imv";
    rev    = metadata.rev;
    sha256 = metadata.sha256;
  };

  preBuild = ''
    # Version is 4.0.1, but Makefile was not updated
    sed -i 's/^VERSION/c\VERSION = ${metadata.rev}/' Makefile
  '';

  nativeBuildInputs = [
    asciidoc
    cmocka
    docbook_xsl
    libxslt
  ];

  buildInputs = [
    freeimage
    libGLU
    librsvg
    libxkbcommon
    pango
    pkgconfig
    wayland
    icu
  ];

  installFlags = [ "PREFIX=$(out)" "CONFIGPREFIX=$(out)/etc" ];

  postFixup = ''
    # The `bin/imv` script assumes imv-wayland or imv-x11 in PATH,
    # so we have to fix those to the binaries we installed into the /nix/store

    sed -i "s|\bimv-wayland\b|$out/bin/imv-wayland|" $out/bin/imv
    sed -i "s|\bimv-x11\b|$out/bin/imv-x11|" $out/bin/imv
  '';

  doCheck = true;

  meta = with stdenv.lib; {
    description = "A command line image viewer for tiling window managers";
    homepage    = https://github.com/eXeC64/imv;
    license     = licenses.gpl2;
    maintainers = with maintainers; [ rnhmjoj markus1189 ];
    platforms   = [ "i686-linux" "x86_64-linux" "aarch64-linux" ];
  };
}
