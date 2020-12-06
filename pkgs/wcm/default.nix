{ stdenv, meson, ninja
, fetchFromGitHub, wayfire
, wf-shell, pkgconfig
, libevdev, wayland
, wayland-protocols
, libxml2, gtk3, glm
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  pname = "wcm";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner = "WayfireWM";
    repo = pname;
    inherit (metadata) rev sha256;
  };

  nativeBuildInputs = [ meson ninja pkgconfig ];
  buildInputs = [ wayfire wf-shell libevdev wayland wayland-protocols libxml2 gtk3 glm ];


  meta = with stdenv.lib; {
    description = "Wayfire Config Manager";
    homepage = https://wayfire.org/;
    license = licenses.mit;
    maintainers = with maintainers; [ CrazedProgrammer ];
    platforms = platforms.linux;
  };
}
