{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/garbageCollect.nix
      ./system/autoUpgrade.nix
      ./system/autoOptimze.nix
      ./system/gnome.nix
      ./system/cosmic.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-ff42987a-cfcc-4861-b70a-e80735efba68".device = "/dev/disk/by-uuid/ff42987a-cfcc-4861-b70a-e80735efba68";
  networking.hostName = "voidheart"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable graphics
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.sensor.iio.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.solomazer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "SoloMazer";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable experimental nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages to be installed on the base system
  environment.systemPackages = with pkgs; [
    fzf
    librewolf
    ripgrep
    fd
    helix
    home-manager
  ];

  # Enable Essential Programs
  programs.fish.enable = true;
  programs.git.enable = true;

  system.stateVersion = "25.11";
}
