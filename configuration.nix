{ config, pkgs, ... }:
{
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # https://search.nixos.org/options?channel=23.11&show=system.stateVersion
  system.stateVersion = "23.11";
  
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disk-config.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostname = "hostname";

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_us.UTF-8";
  console.keyMap = "us";
  console.useXkbConfig = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
  };

  services.xserver = {
    enable = true;
    libinput.enable = true;
    xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape";
    };
    desktopManager.xterm.enable = false;
    displayManager .defaultSession = "none+i3";
    windowManager.i3.enable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];

  programs.neovim.defaultEditor = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}