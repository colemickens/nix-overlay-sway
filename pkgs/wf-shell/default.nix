{ stdenv, fetchFromGitHub
, meson, pkgconfig, ninja
, wayland, wayland-protocols
, cairo, glm
, libevdev, freetype, libinput
, pixman, libxkbcommon, libdrm
, wlroots, wf-config
, libjpeg, libpng
, libGL
, wayfire, gtkmm3, gtk-layer-shell, libpulseaudio, alsaLib
, buildDocs ? true
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "wf-shell";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner = "WayfireWM";
    repo = "wf-shell";
    rev = version;
    sha256 = metadata.sha256;

    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkgconfig meson ninja ];
  buildInputs = [
    # egl glesv2
    wayland wayland-protocols
    cairo glm
    libevdev freetype libinput
    pixman libxkbcommon libdrm
    wlroots wf-config
    libjpeg libpng
    libGL
    wayfire gtkmm3 gtk-layer-shell libpulseaudio alsaLib
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A GTK3-based panel for wayfire";
    homepage    = "https://wayfire.org/";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ colemickens ];
  };
}
