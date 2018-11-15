# nixpkgs-wayland

## Overview

Automated, pre-built packages for Wayland (sway/wlroots) tools for NixOS.

This overlay is built and (somewhat) tested against `nixos-unstable`.
(See the usage section for other options if your system is not on `nixos-unstable`.)

(Sister repositories: [nixpkgs-kubernetes](https://github.com/colemickens/nixpkgs-kubernetes), [nixpkgs-colemickens](https://github.com/colemickens/nixpkgs-colemickens))

## Packages

<details><summary><em><b>Full list of Packages</b></em></summary>

<!--pkgs-->
| Attribute Name | Last Upstream Commit Time |
| -------------- | ------------------------- |
| nixpkgs/nixos-unstable | [2018-11-06 15:05](https://github.com/nixos/nixpkgs-channels/commits/6141939d6e0a77c84905efd560c03c3032164ef1) |
| pkgs/fmt | [2018-11-14 12:07](https://github.com/fmtlib/fmt/commits/f2ee988105b950558ce996cc7cb0ce0972e6d974) |
| pkgs/wlroots | [2018-11-13 11:47](https://github.com/swaywm/wlroots/commits/040d62de0076a349612b7c2c28c5dc5e93bb9760) |
| pkgs/sway-beta | [2018-11-13 11:59](https://github.com/swaywm/sway/commits/47cca240e26992782622a3dc360ed3afec83b47f) |
| pkgs/slurp | [2018-11-14 09:48](https://github.com/emersion/slurp/commits/15b9fe5ade241ab4fbe2702007698425a516b66f) |
| pkgs/grim | [2018-11-14 09:38](https://github.com/emersion/grim/commits/c50a34720cf3d1ab90aba20de800be34e0530e0a) |
| pkgs/mako | [2018-11-14 09:54](https://github.com/emersion/mako/commits/ce1978865935dbff1b3bf3065ff607a4178fe57b) |
| pkgs/kanshi | [2018-11-05 02:42](https://github.com/emersion/kanshi/commits/ed21acce0c52f7893c903f46b09b4a3b55e2c198) |
| pkgs/wlstream | [2018-07-15 14:10](https://github.com/atomnuker/wlstream/commits/182076a94562b128c3a97ecc53cc68905ea86838) |
| pkgs/oguri | [2018-10-28 11:30](https://github.com/vilhalmer/oguri/commits/23bbd965f4744039c1c5a8e1d9604d6b8f6ab75f) |
| pkgs/waybar | [2018-11-14 10:14](https://github.com/Alexays/waybar/commits/1665003d231f6a5b7c53d5020758b1f394ec35aa) |
| pkgs/wayfire | [2018-11-09 01:00](https://github.com/WayfireWM/wayfire/commits/7ee5a6524145584b38690bd9a75b23638db4152d) |
| pkgs/wf-config | [2018-10-22 00:05](https://github.com/WayfireWM/wf-config/commits/8f7046e6c67d4a277b0793b56ff6535f53997bc5) |
| pkgs/redshift-wayland | [2018-11-07 12:03](https://github.com/minus7/redshift/commits/420d0d534c9f03abc4d634a7d3d7629caf29b4b6) |
| pkgs/bspwc | [2018-10-19 05:58](https://github.com/Bl4ckb0ne/bspwc/commits/6a8ba7bc17146544f6e0446f473ff290e77e3256) |
| pkgs/waybox | [2018-10-06 13:44](https://github.com/wizbright/waybox/commits/24669f24f6ce41f99088483f5c55c41498a57662) |
| pkgs/wl-clipboard | [2018-11-13 06:19](https://github.com/bugaevc/wl-clipboard/commits/48c2aed5ed7afe58100751f39e1b9ca05e946570) |
| pkgs/wmfocus | [2018-11-01 11:17](https://github.com/svenstaro/wmfocus/commits/d6f5ff88b7fb5d2eedde3c5989ae49a656ac5adb) |
| pkgs/i3status-rust | [2018-11-12 05:55](https://github.com/greshake/i3status-rust/commits/b198b11e4b02b1a3b20fbfca103c35040435ad08) |
| pkgs/alacritty | [2018-11-14 15:47](https://github.com/jwilm/alacritty/commits/82d0c5ea44f0f8b487c4b9856d50914ed7262fff) |
<!--pkgs-->
</details>

Auto-update script last run: <!--update-->2018-11-14 16:05<!--update-->.

## Usage

There are two ways to use this overlay on NixOS, depending on which
nixpkgs channel you follow.

You can also use this [with Nix on Ubuntu, there is a full walkthrough](docs/sway-on-ubuntu/README.md).

### Usage (nixos-unstable)

This usage just utilizes [`overlay` functionality from `nixpkgs`]().

Note that when using the overlay, the module will automatically reference the correct
`sway-beta` package, just as the environment packages come from `pkg`.

```nix
{ config, lib, pkgs, ... }:
let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
in
  {
    nixpkgs.overlays = [ waylandOverlay ];
    programs.sway-beta.enable = true;
    programs.sway-beta.extraPackages = with pkgs; [
      grim slurp mako wlstream redshift-wayland # essentials
      waybar i3status-rust # optional bars
    ];
  }
```

### Usage (nixos-18.09)

Rather than maintaining an unknown number of backports from nixos-unstable to here
for supporting `nixos-18.09` users, these instructions will pull in select packages
from `nixos-unstable + this overlay` to your environment.

```nix
{ config, lib, pkgs, ... }:
let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandPkgs = import "${builtins.fetchTarball url}/build.nix";
in
  {
    nixpkgs.overlays = [ (self: super: { sway-beta = waylandPkgs.sway-beta; }) ];
    hardware.opengl.enable = true;
    environment.systemPackages =
      with pkgs; [ vim git ] ++
      (with waylandPkgs; [
        grim slurp mako wlstream redshift-wayland # essentials
        waybar i3status-rust # optional bars
      ]);
  }
```

Note: The `sway-beta` module is not available to you. As a result, you need to manually
start sway with `dbus-launch` and you may have issues with `swaylock` due
to the missing security functionality.

```
dbus-launch --exit-with-session $(which sway-beta)
```


## Updates

* `./update.sh`:
  * updates `pkgs/<pkg>/metadata.nix` with the latest commit+hash for each package
  * updates `nixpkgs/<channel>/metadata.nix` per the upstream channel
  * calls `nix-build build.nix` to build all packages against `nixos-unstable`
  * pushes to [nixpkgs-wayland on cachix](https://nixpkgs-wayland.cachix.org)

## Binary Cache

Packages are built as described in the section above and are published to cachix.

See usage instructions at [`nixpkgs-wayland` on cachix](https://nixpkgs-wayland.cachix.org).

