{stdenv, fetchFromGitHub
, pkg-config, gtk3, gtk-layer-shell, gtkmm3, epoxy, nlohmann_json
, wayland, wayland-protocols
, wrapGAppsHook
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  pname = "mauncher";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner = "mortie";
    repo = "mauncher";
    rev = version;
    sha256 = metadata.sha256;
  };

  configureFlags = [
    "-Wno-unused-result"
  ];

  prePatch = ''
    sed -i 's/--cflags gtk+-3.0/--cflags gtk+-3.0 gtk-layer-shell/g' Makefile
    sed -i 's|mauncher: mauncher.o mauncher-win.o mauncher-ipc.o sysutil.o gtk-layer-shell/usr/lib/libgtk-layer-shell.a|mauncher: mauncher.o mauncher-win.o mauncher-ipc.o sysutil.o|g' Makefile
  '';

  NIX_CFLAGS_COMPILE = [ "-Wno-unused-result" ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    gtk3 gtk-layer-shell
    gtkmm3 nlohmann_json epoxy wayland wayland-protocols
    wrapGAppsHook
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Launcher for Wayland.";
    homepage    = "https://github.com/mortie/mauncher";
    license     = licenses.gpl3;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ colemickens ];
  };
}
