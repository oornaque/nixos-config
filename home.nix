{ config, pkgs, ... }:
{
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    # core
    zip
    unzip
    xz
    p7zip
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    strace
    ltrace
    lsof
    lm_sensors
    ethtool
    pciutils
    usbutils
    iproute2
    netcat-openbsd
    docker
    neovim

    ripgrep
    jq
    fzf
    eza
    tldr
    fd
    rofi
    nerdfonts

    # terminals
    kitty

    # browsers
    firefox

    # dev
    gcc
    python3
    
    # cybersec
    nmap
    burpsuite
    mitmproxy

  ];

  programs.neovim.defaultEditor = true;

  programs.git.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.ssh.startAgent = true;

  xsession.windowManager.i3 = {
    enable = true;
    config.modifier = "Mod4";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
