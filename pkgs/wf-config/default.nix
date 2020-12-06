{ stdenv, meson, ninja
, fetchFromGitHub, glm
, libevdev, libxml2, pkgconfig
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  pname = "wf-config";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner = "WayfireWM";
    repo = pname;
    inherit (metadata) rev sha256;
  };

  nativeBuildInputs = [ meson ninja pkgconfig ];
  buildInputs = [ glm libevdev libxml2 ];


  meta = with stdenv.lib; {
    description = "A library for managing configuration files, written for wayfire";
    homepage = https://wayfire.org/;
    license = licenses.mit;
    maintainers = with maintainers; [ CrazedProgrammer ];
    platforms = platforms.linux;
  };
}
