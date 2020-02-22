self: pkgs:
let
waylandPkgs = rec {
  # wlroots-related
  cage             = pkgs.callPackage ./pkgs/cage {};
  drm_info         = pkgs.callPackage ./pkgs/drm_info {};
  gebaar-libinput  = pkgs.callPackage ./pkgs/gebaar-libinput {};
  glpaper          = pkgs.callPackage ./pkgs/glpaper {};
  grim             = pkgs.callPackage ./pkgs/grim {};
  kanshi           = pkgs.callPackage ./pkgs/kanshi {};
  imv              = pkgs.callPackage ./pkgs/imv {};
  lavalauncher     = pkgs.callPackage ./pkgs/lavalauncher {};
  mako             = pkgs.callPackage ./pkgs/mako {};
  oguri            = pkgs.callPackage ./pkgs/oguri {};
  rootbar          = pkgs.callPackage ./pkgs/rootbar {};
  slurp            = pkgs.callPackage ./pkgs/slurp {};
  sway-unwrapped   = pkgs.callPackage ./pkgs/sway {};
  swaybg           = pkgs.callPackage ./pkgs/swaybg {};
  swayidle         = pkgs.callPackage ./pkgs/swayidle {};
  swaylock         = pkgs.callPackage ./pkgs/swaylock {};
  waybar           = pkgs.callPackage ./pkgs/waybar {};
  waybox           = pkgs.callPackage ./pkgs/waybox { wlroots = wlroots-0-9-x; };
  waypipe          = pkgs.callPackage ./pkgs/waypipe {};
  wayvnc           = pkgs.callPackage ./pkgs/wayvnc {};
  wdisplays        = pkgs.callPackage ./pkgs/wdisplays {};
  wev              = pkgs.callPackage ./pkgs/wev {};
  wf-recorder      = pkgs.callPackage ./pkgs/wf-recorder {};
  wlay             = pkgs.callPackage ./pkgs/wlay {};
  wlrobs           = pkgs.callPackage ./pkgs/wlrobs {};
  wl-clipboard     = pkgs.callPackage ./pkgs/wl-clipboard {};
  wl-gammactl      = pkgs.callPackage ./pkgs/wl-gammactl {};
  wldash           = pkgs.callPackage ./pkgs/wldash {};
  wlogout          = pkgs.callPackage ./pkgs/wlogout {};
  wlroots          = pkgs.callPackage ./pkgs/wlroots {};
  wlr-randr        = pkgs.callPackage ./pkgs/wlr-randr {};
  wofi             = pkgs.callPackage ./pkgs/wofi {};
  wtype            = pkgs.callPackage ./pkgs/wtype {};
  xdg-desktop-portal-wlr = pkgs.callPackage ./pkgs/xdg-desktop-portal-wlr {};

  gtk-layer-shell = pkgs.callPackage ./pkgs/gtk-layer-shell {};
  clipman = pkgs.callPackage ./pkgs/clipman {};

  wlroots-tmp = pkgs.callPackage ./pkgs-temp/wlroots {};
  wlroots-0-9-x = pkgs.callPackage ./pkgs-temp/wlroots-0-9-x {};
  date = pkgs.callPackage ./pkgs-temp/date {}; # used by waybar, but temp, upstream to nixpkgs

  # misc
  redshift-wayland = pkgs.callPackage ./pkgs/redshift-wayland {
    inherit (pkgs.python3Packages) python pygobject3 pyxdg wrapPython;
    geoclue = pkgs.geoclue2;
  };
  neatvnc = pkgs.callPackage ./pkgs/neatvnc {};
  obs-studio = pkgs.libsForQt5.callPackage ./pkgs/obs-studio { ffmpeg = pkgs.ffmpeg_4; };

  # i3 related
  i3status-rust    = pkgs.callPackage ./pkgs/i3status-rust {};

  # wayfire stuff
  wf-config        = pkgs.callPackage ./pkgs/wf-config {};
  wf-shell         = pkgs.callPackage ./pkgs/wf-shell {};
  wayfire          = pkgs.callPackage ./pkgs/wayfire { wlroots = wlroots-0-9-x; };
  wcm              = pkgs.callPackage ./pkgs/wcm {};

  # bspwc/wltrunk stuff
  bspwc    = pkgs.callPackage ./pkgs/bspwc { wlroots = wlroots-tmp; };
  wltrunk  = pkgs.callPackage ./pkgs/wltrunk { wlroots = wlroots-tmp; };
};
in
  waylandPkgs // { inherit waylandPkgs; }
