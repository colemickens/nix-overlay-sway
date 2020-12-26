{ stdenv, fetchgit
, pkgconfig, meson, ninja, scdoc
, wayland, wayland-protocols
, libxkbcommon, gtk3, gtk-layer-shell
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "wlogout";
  version = metadata.rev;

  src = fetchgit {
    url = metadata.repo_git;
    rev = metadata.rev;
    sha256 = metadata.sha256;
  };

  nativeBuildInputs = [ pkgconfig meson ninja scdoc ];
  buildInputs = [
    wayland wayland-protocols
    libxkbcommon gtk3 gtk-layer-shell
  ];

  patchPhase = ''
    substituteInPlace style.css --replace \
      "/usr/share/wlogout" \
      "$out/share/${pname}"

    # Fix path in `access(/etc/wlogout/$config_file$)`
    substituteInPlace main.c --replace \
      "/etc/wlogout" \
      "$out/etc/${pname}"
  '';

  mesonFlags = [
    "--datadir=${placeholder "out"}/share"
    "--sysconfdir=${placeholder "out"}/etc"
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A wayland based logout menu";
    homepage    = "https://github.com/ArtsyMacaw/wlogout";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [];
  };
}
