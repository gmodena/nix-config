{ lib, config, pkgs, flake-inputs, ... }:
let
  paperwm-develop = pkgs.gnomeExtensions.paperwm.overrideAttrs (old: {
    version = "39";

    # 2023-12-16: pin gnome45 release. Required as part of the 
    # nixpkgs 23.11 update cycle.
    src = pkgs.fetchFromGitHub {
      owner = "paperwm";
      repo = "PaperWM";
      rev = "6bead84704bf4db8fb7eb2ecd94bb1212059f7c3";
      hash = "sha256-lvMf3rg1wooXG++VvwreSZeOE8TOgTgfVU7SDIpYdI0=";
    };
  });

in
{
  imports = [ ../../default.nix flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub";  }
    "im.riot.Riot"
    "com.logseq.Logseq"
    "com.jetbrains.IntelliJ-IDEA-Community"
    "org.signal.Signal"
    "io.typora.Typora"
    "net.ankiweb.Anki"
    "com.visualstudio.code"
  ];
  services.flatpak.uninstallUnmanaged = true;

  home.packages = with pkgs; [
    firefox
    _1password-gui
    obsidian
    spotify
    whatsapp-for-linux
    tdesktop # Telegram Desktop app
    chromium
    slack
    weechat
    hexchat
    podman
    paperwm-develop
    gnomeExtensions.appindicator
    synology-drive-client
    powertop
    albert
    gcc
    gnome.gnome-tweaks
    protonvpn-gui
    yacreader
    qbittorrent
    tor-browser-bundle-bin
    gnumake
    chiaki
    steam
    steam-run
    steam-rom-manager
    quickemu
  ];
  # Enable fractional scaling for Gnome DM.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
