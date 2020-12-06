{ fetchFromGitHub }:
# picked from https://github.com/NixOS/nixpkgs/blob/3e7fae8eae52f9260d2e251d3346f4d36c0b3116/pkgs/desktops/gnome-3/core/gvc-with-ucm-prePatch.nix
let
  # We need a gvc different then that which is shipped in the source tarball of
  # whatever package that imports this file
  gvc-src-with-ucm = fetchFromGitHub {
    owner = "GNOME";
    repo = "libgnome-volume-control";
    rev = "468022b708fc1a56154f3b0cc5af3b938fb3e9fb";
    sha256 = "sha256-DWiNzUrt+ua5bqHL87uAQ4smbMOjZy+CO1uUXA6imQc=";
  };

  wayland-logout = fetchFromGitHub {
    owner = "soreau";
    repo = "wayland-logout";
    rev = "ab7c1436c1194fc8626d2e7a093ced1805684ad4";
    sha256 = "sha256-iTt7qyVjYGBYuw8uxHPvI2UqCVXeNO1IVk1A4+fulfc=";
  };
in
''
  rm -r ./subprojects/gvc ./subprojects/wayland-logout
  cp -r ${gvc-src-with-ucm} ./subprojects/gvc
  cp -r ${wayland-logout} ./subprojects/wayland-logout
''
